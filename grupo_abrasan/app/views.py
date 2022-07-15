
from email import message
from email.headerregistry import Group
from math import prod
from turtle import title
from django.shortcuts import get_object_or_404, render,redirect, get_list_or_404
from .models import *
from django.http import Http404
from .forms import *
from django.contrib import messages
from django.core.paginator import Paginator
from django.db.models import Q
from django.db.models import Count   
from django.db.models import Sum      
import datetime
import json
from django.contrib.auth.models import Group
from django.core.serializers.json import DjangoJSONEncoder
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.decorators import login_required,permission_required
from django.contrib.auth import update_session_auth_hash
from django.contrib.auth.forms import PasswordChangeForm
# ------------------- INVENTARIO ------------------------------------

def register(request):
    if request.method=='POST':
        form=UserRegisterForm(request.POST)
        if form.is_valid():
            user=form.save()
            if( request.POST.get('user_type') == '1'):
                group=Group.objects.get(name='admin')
                user.groups.add(group)
            elif ( request.POST.get('user_type') == '2'):
                group=Group.objects.get(name='bodega')
                user.groups.add(group)
            elif ( request.POST.get('user_type') == '3'):
                group=Group.objects.get(name='residente')
                user.groups.add(group)
            username=form.cleaned_data['username']
            messages.success(request,f'Usuario {username} creado')
            return redirect ('/inventario/panel')
    else:
        form=UserRegisterForm()
    
    context={'form':form}
    return render(request,'app/register.html',context)
@login_required
def change_password(request):
    if request.method == 'POST':
        form = PasswordChangeForm(data=request.POST, user=request.user)
        if form.is_valid():
            user = form.save()
            update_session_auth_hash(request, user)  # Important!
            messages.success(request, 'Contraseña Modificada Correctamente')
            return redirect('/inventario/panel')
        else:
            messages.error(request, 'Por favor intenta de nuevo')
    else:
        form = PasswordChangeForm(request.user)
    return render(request, 'app/cambiar_contra.html', {
        'form': form
    })

def panel(request):
    b= Bodega.objects.all().count()
    o= Obra.objects.all().count() 
    finalizado=Obra.objects.filter(status=2).count()
    villas=Villa.objects.count() 
    table_obra=Bodega.objects.select_related('obra').values('obra__nombre','nombre','obra__status')
    inventario=Producto.objects.all().values('descripcion','unidad').order_by('descripcion')[:5]
    
    now = datetime.datetime.now()
    last_week = now - datetime.timedelta(days=7)
    s=Solicitud.objects.filter(fecha__range=[last_week,now]).values('solicitud').annotate(total=Count('solicitud'))[:5]
    
    data={
        'bodegas':b,'obras':o,'finalizado':finalizado,'villas':villas,'table_obra':table_obra,'inventario':inventario,'solicitud':s
    } 
    
    
    return render(request,'app/dashboard.html',data)

@permission_required('app.view_producto')
def listar_inventario(request):
    
    productos=Producto.objects.all()
   
    
    data={'productos':productos}
    print(data)
    
   
    
    return render(request,'app/inventario/inventario.html',data)
@permission_required('app.add_producto')
def agregar_producto(request):
    
    try:
        id=Producto.objects.latest('id').id
        clave="INV-"+str(id+1)
    except Producto.DoesNotExist:
        clave="INV-"+str("1")
   
    data={
        'form':ProductoForm(),
        'clave':clave
        
    }
    
    if request.method =="POST":
        
        
        formulario=ProductoForm(data=request.POST)
        if formulario.is_valid():
            formulario.save()
            messages.success(request, "Producto Agregado Correctamente")
            return redirect("/inventario/listar-inventario")
        else:
            data["form"]=formulario
            
    return render(request, 'app/inventario/agregar.html',data)
@permission_required('app.change_producto')
def modificar_producto(request,id):
    producto=get_object_or_404(Producto,id=id)
    data={
        'form':ProductoForm(instance=producto),
        'producto':producto
    }
    
    if request.method== 'POST':
        formulario=ProductoForm(data=request.POST,instance=producto)
        #print(formulario)
        print(request.POST)
        if formulario.is_valid():
            print(formulario.errors)
            formulario.save()
            messages.success(request, "Modificado correctamente")
            return redirect("/inventario/listar-inventario")
        data["form"]=formulario
    return render(request,'app/inventario/modificar.html',data)
@permission_required('app.delete_producto')
def eliminar_producto(request,id):
    producto=get_object_or_404(Producto,id=id)
    producto.delete()
    messages.success(request, "Eliminado correctamente")
    return redirect("/inventario/listar-inventario")

# ----------------------- BODEGA -------------------------------------
@permission_required('app.view_bodega')
def listar_bodegas(request):
   
    bodegas=Bodega.objects.all()
   
    
    
    data={
        'bodegas':bodegas
    }
    
    
    return render(request,'app/bodega/bodegas.html',data)  
@permission_required('app.add_bodega')
def agregar_bodega(request):
    obra=Obra.objects.all()
    data={
        'form':BodegaForm(),
        'obras':obra
    }
    
    if request.method =="POST":
        formulario=BodegaForm(data=request.POST)
        
        if formulario.is_valid():
            formulario.save()
            messages.success(request, "Bodega Agregada Correctamente")
            return redirect("/inventario/listar-bodegas")
        else:
            data["form"]=formulario
            
    return render(request, 'app/bodega/agregar.html',data)
@permission_required('app.change_bodega')
def modificar_bodega(request,id):
    obra=Obra.objects.all()
    bodega=get_object_or_404(Bodega,id=id)
    data={'form':BodegaForm(instance=bodega),'obras':obra}
    if request.method== 'POST':
        formulario=BodegaForm(data=request.POST,instance=bodega)
        if formulario.is_valid():
            formulario.save()
            messages.success(request, "Modificado correctamente")
            return redirect("/inventario/listar-bodegas")
        data["form"]=formulario
    return render(request,'app/bodega/modificar.html',data)
@permission_required('app.delete_bodega')
def eliminar_bodega(request,id):
    producto=get_object_or_404(Bodega,id=id)
    producto.delete()
    messages.success(request, "Eliminado correctamente")
    return redirect("/inventario/listar-bodegas")
#--------------------- OBRA ------------------------------------------
@permission_required('app.view_obra')
def listar_obras(request):
    
    obras=Obra.objects.all()

    data={
        'obras':obras
    }
    return render(request,'app/obras/obras.html',data)  
@permission_required('app.add_obra')
def agregar_obra(request):
    obras=Obra.objects.all()
    data={
        'form':ObraForm(),
        'obras':obras
    }
    
    if request.method =="POST":
        formulario=ObraForm(data=request.POST)
        
        if formulario.is_valid():
            formulario.save()
            messages.success(request, "Obra Creada Correctamente")
            return redirect("/inventario/listar-obras")
        else:
            data["form"]=formulario
            
    return render(request, 'app/obras/agregar.html',data)
@permission_required('app.change_obra')
def modificar_obra(request,id):
    obra=get_object_or_404(Obra,id=id)
    data={'form':ObraForm(instance=obra)}
    if request.method== 'POST':
        formulario=ObraForm(data=request.POST,instance=obra)
        if formulario.is_valid():
            formulario.save()
            messages.success(request, "Modificado correctamente")
            return redirect("/inventario/listar-obras")
        data["form"]=formulario
    return render(request,'app/obras/modificar.html',data)
@permission_required('delete.obra')
def eliminar_obra(request,id):
    
    obra=get_object_or_404(Obra,id=id)
    obra.delete()
    messages.success(request, "Eliminado correctamente")
    return redirect("/inventario/listar-obras")

#--------------------- VILLA ------------------------------------------
@permission_required('app.view_villa')
def listar_villas(request):
   
    villas=Villa.objects.all()
    
    
    
    data={
        'villas':villas,
    }
    return render(request,'app/villas/villas.html',data)  
@permission_required('app.add_villa')
def agregar_villa(request):
    obras=Obra.objects.all()
    data={
        'form':VillaForm(),
        'obras':obras
    }
    
    if request.method =="POST":
        formulario=VillaForm(data=request.POST)
        
        if formulario.is_valid():
            formulario.save()
            messages.success(request, "Villa Agregada Correctamente")
            return redirect("/inventario/listar-villas")
        else:
            data["form"]=formulario
            
    return render(request, 'app/villas/agregar.html',data)
@permission_required('app.change_villa')
def modificar_villa(request,id):
    villa=get_object_or_404(Villa,id=id)
    obras=Obra.objects.all()
    data={'form':VillaForm(instance=villa),'obras':obras}
    if request.method== 'POST':
        formulario=VillaForm(data=request.POST,instance=villa)
        if formulario.is_valid():
            formulario.save()
            messages.success(request, "Modificado correctamente")
            return redirect("/inventario/listar-villas")
        data["form"]=formulario
    return render(request,'app/villas/modificar.html',data)
@permission_required('app.delete_villa')
def eliminar_villa(request,id):
    
    villa=get_object_or_404(Villa,id=id)
    villa.delete()
    messages.success(request, "Eliminado correctamente")
    return redirect("/inventario/listar-villas/")

#----------------- PRODUCTOS A BODEGA --------------------------
@permission_required('app.add_bodegaproductos')
def bodega_addproduct(request,id):
    #productos=Producto.objects.only("id","clave","categoria","descripcion","proveedor","unidad","disp")
    bodegas=Bodega.objects.all()
    producto=Producto.objects.get(id=id)
    data={
        'producto':producto,
        'bodegas': bodegas,
        'form': BodegaProducto(instance=BodegaProductos),
    }
    #print(data)
    if request.method =="POST":
        formulario=BodegaProducto(data=request.POST)
        print(request.POST)
        
        print(formulario.errors)
        if formulario.is_valid():
            bodega=request.POST.get("bodega")
            print(bodega)
            exist=BodegaProductos.objects.filter(producto_id=id,bodega_id=bodega).exists()
            print(exist)
            if exist:
                messages.error(request, "Ya existe producto en bodega")
                return redirect("/inventario/listar-producto-bodega/"+bodega+"/")
            else:
                if (producto.disp >= int(request.POST.get("cantidad")) ): 
                        print("entra")
                        formulario.save()
                        p= producto.disp - int(request.POST.get("cantidad"))
                        producto.disp=p
                        producto.save()
                        messages.success(request, "Producto Agregado Correctamente, tienes "+ str(producto.disp)+" disponibles en inventario")
                        return redirect("/inventario/listar-producto-bodega/"+bodega+"/")
                else:
                        print(formulario.errors)
                        messages.error(request, "Producto No agregado, tienes "+ str(producto.disp)+" disponibles en inventario")
                        return redirect("/inventario/listar-inventario")
    return render(request,'app/inventario/agregar-a-bodega.html',data)
@permission_required('app.add_bodegaproductos')
def bodega_traspaso(request,id,bodega,bp):
    producto=Producto.objects.get(id=id)
    p=BodegaProductos.objects.get(producto_id=id,bodega_id=bodega,id=bp)
    bodega=Bodega.objects.get(id=bodega)
    bodegas=Bodega.objects.exclude(id=bodega.id)
    
    data={
        'producto':producto,
        'id':p,
        'b':bodega,
        'bodegas':bodegas,
        'form': BodegaProducto(),
    }
    if request.method =="POST":
        formulario=BodegaProducto(data=request.POST)
        print(request.POST)
        print(formulario.errors)
        if formulario.is_valid():
            
            
            if (p.cantidad >= int(request.POST.get("cantidad"))): 
                    print("entra")
                    formulario.save()
                    x= p.cantidad - int(request.POST.get("cantidad"))
                    print(x)
                    p.cantidad=x
                    print(p.cantidad)
                    p.save()
                    messages.success(request, "Producto Agregado Correctamente, tienes "+ str(p.cantidad)+" disponibles en Bodega")
                    return redirect("/inventario/listar-producto-bodega/"+str(bodega.id)+"/")
            else:
                    print(formulario.errors)
                    messages.error(request, "No se agrego traspaso producto, tienes "+str(p.cantidad)+" disponible en Bodega")
                    return redirect("/inventario/listar-producto-bodega/"+str(bodega.id)+"/")
    return render(request,'app/bodega/traspaso.html',data)
    
        
@permission_required('app.view_bodegaproductos')
def listar_productobodega(request,id):
    
    queryset= request.GET.get("buscar")
    print(queryset)
    productos=BodegaProductos.objects.select_related('bodega','producto').filter(bodega=id).values('id','ubicacion','producto_id__id','producto_id__clave','producto_id__descripcion','producto_id__unidad','cantidad','minimo','bodega_id')
    

    bodega=Bodega.objects.get(id=id)
    data={
        'productos':productos,
        'bodega':bodega,
        
    }
    return render(request,'app/bodega/productos-bodegas.html',data)  
@permission_required('app.change_bodegaproductos')
def modificar_productobodega(request,id,bodega,bp):
    producto=Producto.objects.get(id=id)
    bp=get_object_or_404(BodegaProductos,producto_id=id,id=bp)
    data={
        'producto':producto,
        'form': BodegaProducto(instance=bp),
        'bp':bp,
        'bodega':bodega
    }
    if request.method =="POST":
        formulario=BodegaProducto(data=request.POST,instance=bp)
        anterior=int(bp.cantidad)
        print("anterior"+str(anterior))
        nuevo=int(request.POST.get("cantidad"))
        print("nuevo"+str(nuevo))
        a=anterior-nuevo
        print(a)
        print(formulario.errors)
        if formulario.is_valid():
            if (producto.disp >= int(request.POST.get("cantidad"))): 
                print(producto.disp)
                print(a)
                if (a<0):
                    p=int(producto.disp) + int(a)
                else:
                    p=int(producto.disp) - int(a)
                print(p)
                producto.disp=p
                producto.save()
                formulario.save()
                messages.success(request, "Producto Agregado Correctamente, tienes "+ str(producto.disp)+" disponibles en inventario")
                return redirect("/inventario/listar-producto-bodega/"+bodega+"/")
            else:
                messages.error(request, "Producto No modificado, tienes "+ str(producto.disp)+" disponibles en inventario")
                return redirect("/inventario/listar-producto-bodega/"+bodega+"/")
       
    return render(request,'app/bodega/modificar-producto-bodega.html',data)

@permission_required('app.delete_bodegaproductos')
def eliminar_productobodega(request,id,bodega):
    productobodega=get_list_or_404(BodegaProductos,producto_id=id)
    for p in productobodega:
        p.delete()
    #productobodega.delete()
    messages.success(request, "Eliminado correctamente")
    return redirect("/inventario/listar-producto-bodega/"+bodega+"/")
#------------------- PRODUCTOS A VILLA ---------------------------
@permission_required('app.add_insumos')
def villa_addproduct(request,id,bodega,bp):
    obra=Bodega.objects.select_related('obra').filter(id=bodega).values('obra_id__id')
    print(obra)
    villa= Villa.objects.select_related('obra').filter(obra_id__in=obra).values()
    print(villa)
    producto=BodegaProductos.objects.select_related('producto').get(producto_id=id,bodega_id=bodega,id=bp) 
    #print(producto.producto.descripcion)    print(producto.producto_id)
    p=BodegaProductos.objects.get(producto_id=id,bodega_id=bodega,id=bp)
    print(p.cantidad)
    data={
        'obra':obra,
        'villas':villa,
        'producto':producto,
        'bodega':bodega,
        'form': InsumosForm(),
    }
    if request.method =="POST":
        formulario=InsumosForm(data=request.POST)
        print(request.POST)
        print(formulario.errors)
        if formulario.is_valid():
            if (p.cantidad >= int(request.POST.get("cantidad"))): 
                    print("entra")
                    formulario.save()
                    x= p.cantidad - int(request.POST.get("cantidad"))
                    p.cantidad=x
                    p.save()
                    messages.success(request, "Producto Agregado Correctamente, tienes "+ str(p.cantidad)+" disponibles en bodega")
                    return redirect("/inventario/listar-producto-bodega/"+bodega+"/")
            else:
                    print(formulario.errors)
                    messages.error(request, "No se agrego producto, tienes "+str(p.cantidad)+" disponible en inventario")
                    return redirect("/inventario/listar-producto-bodega/"+bodega+"/")
    return render(request,'app/bodega/asignar-a-villa.html',data)

@permission_required('app.view_insumos')
def explosion_insumos(request,id):
    producto=BodegaProductos.objects.select_related('producto')
    i=Insumos.objects.select_related('bodegaproducto').filter(bodegaproducto__in=producto).filter(villa_id=id).order_by("fecha")
    villa=Villa.objects.get(id=id)
    data={
        'insumos':i,
        'villa':villa
    }
    
    return render(request,'app/villas/explosion-insumos.html',data)  
@permission_required('app.view_insumos')
def view_insumos(request,villa):
    #from django.db.models import Sum  
    now = datetime.datetime.now()
    last_week = now - datetime.timedelta(days=7)
    print(last_week)
    print(now)
    
    p=BodegaProductos.objects.select_related('producto')
    print(p)
    producto=BodegaProductos.objects.select_related('producto')
    i=Insumos.objects.filter(fecha__range=[last_week,now]).filter(villa_id=villa,bodegaproducto__in=producto).values('fecha','bodegaproducto_id','cantidad','villa_id').annotate(total=Sum('cantidad')).order_by("fecha")
 
    identificador=Villa.objects.get(id=villa)
    print(identificador)
    view_s = json.dumps(list(i), cls=DjangoJSONEncoder)
    print(view_s)
    prod_s=json.dumps(list(p.values('producto_id','producto_id__descripcion','id')), cls=DjangoJSONEncoder)
    print(prod_s)
    return render(request,'app/prueba.html',{'view_s':view_s,'prod_s':prod_s,'now':now.strftime('%m/%d/%Y'),'last_week':last_week.strftime('%m/%d/%Y'),'villa':villa,'identificador':identificador})
#------------------- REQUISICIONES -------------------------------
@permission_required('app.add_solicitud')
def solicitud(request,id):
    productos=BodegaProductos.objects.select_related('bodega','producto').filter(bodega=id).values('id','producto_id__id','producto_id__clave','producto_id__descripcion','producto_id__unidad','cantidad','minimo','bodega_id','producto_id')
    bodega=Bodega.objects.select_related('obra').get(id=id) 
    data={
        'productos':productos,
        'bodega':bodega,
        'form':SolicitudForm()
    }
    if request.method =="POST":
        print(request.POST)
        cantidad=[]
        prod=[]
        desc=[]
        un=[]
        print(request.POST.getlist("descripcion"))
        for c in request.POST.getlist("cantidad"):
            cantidad.append(c)
        for p in request.POST.getlist("bodegaproducto"):
            prod.append(p)
        for d in request.POST.getlist("descripcion"):
            desc.append(d)
        for u in request.POST.getlist("unidad"):
            un.append(u)
        
        print(prod)
        i=0
        x=0
        y=0
        for cant in cantidad:
            if(cant == ''):
                pass
            else:
                solicita=request.POST.get("solicita")
                fecha=request.POST.get("fecha")
                obra=request.POST.get("obra")
                solicitud=request.POST.get("solicitud")
                cantidad=cant
                bodegaproducto=prod[i]
                print(bodegaproducto)
                descripcion=desc[x]
                unidad=un[y]
                datos={'solicita':solicita,'fecha':fecha,'obra':obra,'solicitud':solicitud,'cantidad':cantidad,'bodegaproducto':bodegaproducto,'descripcion':descripcion,'unidad':unidad}
                print(datos)
                formulario=SolicitudForm(datos)
                print(formulario.errors)
                formulario.save()
            
                
            i+=1
            y+=1
            x+=1
            
            
        if formulario.is_valid():
            print(formulario.errors)
            messages.success(request,"Solicitud enviada")
            return redirect("/inventario/solicitudes/")
        else:
            data["form"]=formulario
                
    
    return render(request,'app/requisiciones/solicitud.html',data)
@permission_required('app.view_solicitud')
def solicitudes(request):
    #productos=BodegaProductos.objects.select_related('bodega','producto').filter(bodega=id).values('producto_id__id','producto_id__clave','producto_id__descripcion','producto_id__unidad','cantidad','minimo','bodega_id','producto_id')
    #bodega=Bodega.objects.select_related('obra').get(id=id) 
    solicitud=Solicitud.objects.all().select_related('obra').values('solicitud','obra__nombre').annotate(total=Count('solicitud')).order_by('solicitud','total')
    data={
        'solicitud':solicitud,
    }
    return render(request,'app/requisiciones/solicitudes.html',data)
@permission_required('app.add_compra')
def compra(request,solicitud):
    solicitudes=Solicitud.objects.filter(solicitud=solicitud)    
    
    data={
        'solicitudes':solicitudes,
        'form':CompraForm(),
    }  
    if request.method =="POST":
        solicitud=[]
        cantidades=[]
        for s in request.POST.getlist("solicitud"):
            solicitud.append(s)
        for c in request.POST.getlist("compra"):
            cantidades.append(c)
        
        print(cantidades)
        print(solicitud)
        
        i=0
        for cant in cantidades:
            if(cant == ''):
                pass
            else:
                sol=solicitud[i]
                cantidad=cant
                datos={'solicitud':sol,'compra':cantidad}
                formulario=CompraForm(datos)
                print(formulario.errors)
                formulario.save()
            i+=1
            
    
        if formulario.is_valid():
            print(formulario.errors)
            
            messages.success(request, "Compra Registrada")
            return redirect("/inventario/solicitudes/")
        else:
            data["form"]=formulario
            

    
        
       
            
    
    return render(request,'app/requisiciones/compras.html',data)
@permission_required('app.view_compra')
def ver_compra(request,solicitud):
    
    solicitudes=Solicitud.objects.select_related('bodegaproducto','compra').values('bodegaproducto_id','solicitud','cantidad','unidad','descripcion','bodegaproducto_id__cantidad', 'compra','id','fecha','solicita').order_by('solicitud').filter(solicitud=solicitud)  
    id=Solicitud.objects.select_related('bodegaproducto','compra','recepcion').values('id').filter(solicitud=solicitud)    
    compra=Compra.objects.select_related('solicitud').filter(solicitud_id__in=id).values() 
    data={
        'solicitudes':solicitudes,  
        'compra':compra      
    }  

    return render(request,'app/requisiciones/ver-compra.html',data)
@permission_required('app.change_compra')
def modificar_compra(request,id):
    compra=get_object_or_404(Compra,solicitud_id=id)
    solicitudes=Solicitud.objects.select_related('bodegaproducto','compra').values('bodegaproducto_id','solicitud','cantidad','descripcion','bodegaproducto_id__cantidad','compra','id').order_by('solicitud').filter(id=id)
    print(solicitudes)
    
   
    data={
        'form':CompraForm(instance=compra),
        'solicitudes':solicitudes
    }
    if request.method== 'POST':
        formulario=CompraForm(data=request.POST,instance=compra)
        if formulario.is_valid():
            formulario.save()
            messages.success(request, "Modificado correctamente")
            return redirect("/inventario/solicitudes")
        data["form"]=formulario
    return render(request,'app/requisiciones/modificar-compra.html',data)

@permission_required('app.view_recepcion')
def recepcion_bodega(request):
    solicitud=Solicitud.objects.all().select_related('obra').values('solicitud','obra_id','obra__nombre').annotate(total=Count('solicitud')).order_by('solicitud','total')
    
    data={
        'solicitud':solicitud
    } 
    return render(request,'app/requisiciones/recepcion.html',data)  
@permission_required('app.view_recepcion')
def ver_recepcion(request,solicitud):
    solicitudes=Solicitud.objects.select_related('bodegaproducto','compra','recepcion').values('bodegaproducto_id','cantidad','unidad','solicitud','bodegaproducto_id__cantidad','descripcion','id','solicita','compra','recepcion__llegada','recepcion__pendiente','recepcion__utilizado','recepcion__saldo').filter(solicitud=solicitud)
    id=Solicitud.objects.select_related('bodegaproducto','compra','recepcion').values('id').filter(solicitud=solicitud)    
    compra=Compra.objects.select_related('solicitud').filter(solicitud_id__in=id).values() 
    data={
        'solicitudes':solicitudes,     
        'compra':compra   
    }  

    return render(request,'app/requisiciones/ver-recepcion.html',data)
@permission_required('app.change_recepcion')
def modificar_recepcion(request,id):
    recepcion=get_object_or_404(Recepcion,solicitud_id=id)
    solicitudes=Solicitud.objects.select_related('bodegaproducto','compra').values('bodegaproducto_id','solicitud','cantidad','descripcion','bodegaproducto_id__cantidad','compra','id').order_by('solicitud').filter(id=id)
    producto=Solicitud.objects.select_related('bodegaproducto','compra','recepcion').values('bodegaproducto_id').filter(id=id)
    productobodega=BodegaProductos.objects.get(id__in=producto)
    
    s=Recepcion.objects.select_related('solicitud').get(solicitud_id=id).solicitud
    nsoli=s.solicitud
    
    #print(solicitudes)
    
    #SALDO PRODUCTO EN BODEGA + LLEGADA - UTILIZADO
    
    data={
        'form':RecepcionForm(instance=recepcion),
        'solicitudes':solicitudes
    }
       
    if request.method =="POST":
            formulario=RecepcionForm(data=request.POST,instance=recepcion)
            if formulario.is_valid():
                        llegada=request.POST.get("llegada")
                        utilizado=request.POST.get("utilizado")
                        sa= int(productobodega.cantidad)+int(llegada)-int(utilizado)
                        print(sa)
                        formulario.save()
                        Recepcion.objects.filter(solicitud_id=request.POST.get("solicitud")).update(saldo=sa)
                    
                        messages.success(request, "Modificado Correctamente")
                        return redirect("/inventario/ver-recepcion-registro/"+str(nsoli))
            else:
                messages.error(request, "No se modifico recepcion , vuelve a intentarlo")
                return redirect("/inventario/recepcion-bodega")
    return render(request,'app/requisiciones/modificar-recepcion.html',data)
@permission_required('app.add_recepcion')
def recepcion_registro(request,solicitud):
    solicitudes=Solicitud.objects.select_related('bodegaproducto','compra').values('bodegaproducto_id','solicitud','cantidad','descripcion','unidad','bodegaproducto_id__cantidad','compra','id').annotate(total=Count('solicitud')).order_by('solicitud','total').filter(solicitud=solicitud)
    id=Solicitud.objects.select_related('bodegaproducto','compra','recepcion').values('id').filter(solicitud=solicitud)    
    compra=Compra.objects.select_related('solicitud').filter(solicitud_id__in=id).values() 
    data={
        'solicitudes':solicitudes,
        'form':RecepcionForm(),
        'compra':compra
    }
    if request.method =="POST":
        llegada=[]
        pendiente=[]
        utilizado=[]
        solicitud=[]
        
        for ll in request.POST.getlist("llegada"):
            llegada.append(ll)
        for p in request.POST.getlist("pendiente"):
            pendiente.append(p)
        for u in request.POST.getlist("utilizado"):
            utilizado.append(u)
            
        for s in request.POST.getlist("solicitud"):
            solicitud.append(s)
        
        print(request.POST)
        print(llegada)
        print(pendiente)
        print(utilizado)
        i=0
        x=0
        y=0
        for llega in llegada:
            if(llega == ''):
                pass
            else:
                sol=solicitud[y]
                sal=request.POST.get("saldo")
                llego=llega
                pend=pendiente[i]
                if pend == '':
                    pend=0
                usado=utilizado[x]
                datos={'solicitud':sol,'llegada':llego,'pendiente':pend,'utilizado':usado,'saldo':sal}
                print(datos)
                formulario=RecepcionForm(datos)
                print(formulario.errors)
                formulario.save()
            i+=1
            x+=1
            y+=1
    
        if formulario.is_valid():
            
            messages.success(request, "Recepcion Registrada")
            return redirect("/inventario/recepcion-bodega/")
        else:
            data["form"]=formulario
    
    return render(request,'app/requisiciones/recepcion_registro.html',data)  
@permission_required('app.view_solicitud')
def requisiciones(request,solicitud):
    solicitudes=Solicitud.objects.select_related('bodegaproducto','compra','recepcion').values('bodegaproducto_id','solicita','unidad','cantidad','solicitud','bodegaproducto_id__cantidad','descripcion','id','solicita','compra','recepcion__llegada','recepcion__pendiente','recepcion__utilizado','recepcion__saldo').filter(solicitud=solicitud)
    id=Solicitud.objects.select_related('bodegaproducto','compra','recepcion').values('id').filter(solicitud=solicitud)    
    compra=Compra.objects.select_related('solicitud').filter(solicitud_id__in=id).values() 
    solicita=Solicitud.objects.select_related('obra').values('solicita','fecha','obra__nombre').filter(solicitud=solicitud).first()
    print(solicita)
    data={
        'solicitudes':solicitudes,
        'form':RecepcionForm(),
        'compra':compra,
        'solicitud':solicitud,
        'solicita':solicita,
    }
    
    return render(request,'app/requisiciones/ver-requisicion.html',data)  

