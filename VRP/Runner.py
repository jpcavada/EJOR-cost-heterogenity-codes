import subprocess
import shutil
import time

#Declare paths for AMPL and the model files
ampl_path = '/home/juano/Desktop/amplide.linux64'
model_path = '"/home/juano/Desktop/02_20_VRP_2/'

#model_command = 'ampl "C:\\Users\\Juan Pablo\\Desktop\\asdf\\run_week.run"'

#Variables Globales
Lcap = 5
fleet_size = 20
max_clientes = 5200000
total_dias = 5
costo_distancia = 55
costo_atraso = 80

#Create run_week.run file
def write_runWeek (model_path, output_file_name, log_file_name):
    try:
        f = open('run_week.run','w+')
        f.write('model '+ model_path + 'sp1.mod";\n')
        f.write('model '+ model_path + 'mp.mod";\n')

        f.write('data '+ model_path + 'data0.dat";\n')
        f.write('data '+ model_path + 'data1.dat";\n')
        f.write('data '+ model_path + 'data2.dat";\n')
        f.write('data '+ model_path + 'data3.dat";\n')
        f.write('param Out symbolic := '+ model_path + output_file_name + '";\n')
        f.write('option log_file '+ model_path + log_file_name + '";\n')

        f.write('include '+model_path + 'prob.run";')
        f.close()
    except:
        print('Error al escribit archivo run_week.run')

class cliente:
    def __init__(self, nombre, dia, comuna, tiempo, penalty):
        self.nombre = nombre
        self.dia = int(dia)
        self.comuna = comuna
        self.tiempo = int(tiempo)
        self.penalty = int(penalty)
        self.model_id = -1


###################################################################################################################


#Get all instances raw data
try:
    #Creo una lista con la cantidad de clientes base de cada dia
    n_clientes_dia = []
    for i in range(5):
        n_clientes_dia.append(0)

    clientes = []
    data_file = open("alldata.txt",'r')
    for line in data_file.readlines():
            if line[:1] != '#':
                aux = line.split()
                clientes.append(cliente(aux[0],aux[1], aux[2], aux[4], aux[3]))
                n_clientes_dia[clientes[-1].dia-1] += 1
                clientes[-1].model_id = n_clientes_dia[clientes[-1].dia-1]
    data_file.close()
except:
    print('Error al leer archivo alldata.txt')


#Contador de clientes atrazados de cada dia.
n_atrasados_dia=[]
for i in range(5):
    n_atrasados_dia.append(0)

#clientes.append(cliente("ATRAZADO_21",-2,1,100,21))
#clientes.append(cliente("ATRAZADO_22",-2,1,100,22))
#clientes.append(cliente("ATRAZADO_23",-2,1,100,23))
#clientes.append(cliente("ATRAZADO_25",-2,1,100,24))
#clientes.append(cliente("ATRAZADO_31",-3,1,100,31))
#clientes.append(cliente("ATRAZADO_32",-3,1,100,32))
#clientes.append(cliente("ATRAZADO_41",-4,1,100,41))
#clientes.append(cliente("ATRAZADO_42",-4,1,100,42))
#clientes.append(cliente("ATRAZADO_43",-4,1,100,43))
#clientes.append(cliente("ATRAZADO_51",-5,1,100,51))
#clientes.append(cliente("ATRAZADO_52",-5,1,100,52))

#for c in clientes:
#    print(c.nombre, c.dia, c.model_id, c.penalty)

#Inicio Iteracion por N dias
#Dia 1 del algoritmo
iter_dia = 1
total_clientes_pendientes = 0
FO_Firma=0
FO_Cust=0

for iter_dia in range(1,total_dias+1):
    t_start=time.time()
    print('\n##########################################################################\n                                   DIA '+str(iter_dia)+'\n                                     \n##########################################################################\n')
     #Definimos los nombres para los archivos de salida del dia
    output_file = '_salida_'+str(iter_dia)+'.txt'
    log_file = '_log_'+str(iter_dia)+'.txt'


    #Crear data1.dat Por ahora no cambia, hardcoded para 5 comunas

    #Crear data2.dat id, place, penalty, service
    data2_lines = []
    cuenta_clientes = 0
    for i in clientes:
        if i.dia == iter_dia:
            cuenta_clientes += 1 #para reducir la cantidad de clientes si es necesario
            #i.model_id = id_cliente_modelo
            data2_lines.append(str(i.model_id) +" "+ str(i.comuna) +" "+ str(i.penalty) +" "+ str(i.tiempo))

        if cuenta_clientes == max_clientes:
            if n_clientes_dia[iter_dia-1] > cuenta_clientes:
                print('Reducido numero de clientes de '+str(n_clientes_dia[iter_dia-1])+ ' a '+str(cuenta_clientes))
                n_clientes_dia[iter_dia-1] = cuenta_clientes
            break

    #agregamos los clientes atrazados
    n_atrasados_dia[iter_dia-1] = 0
    for i in clientes:
        if i.dia == -iter_dia:
            n_atrasados_dia[iter_dia-1] +=1
            data2_lines.append(str(n_clientes_dia[iter_dia-1]+n_atrasados_dia[iter_dia-1]) +" "+ str(i.comuna) +" "+ str(i.penalty) +" "+ str(i.tiempo))



    #Escritura de archivo data2.dat
    try:
        data2_file = open('data2.dat','w+')
        data2_file.write('param: place penalty service :=\n')
        #data2_file.write('0 1 50 0\n') #DEPOT

        for i in data2_lines:
            data2_file.write(i+"\n")
        data2_file.write(str(n_clientes_dia[iter_dia-1] + n_atrasados_dia[iter_dia-1] + 1) + ' 6 0 0\n')
        data2_file.write(str(n_clientes_dia[iter_dia-1] + n_atrasados_dia[iter_dia-1] + 2) + ' 6 0 0\n')
        data2_file.write(str(n_clientes_dia[iter_dia-1] + n_atrasados_dia[iter_dia-1] + 3) + ' 6 0 0\n')
        data2_file.write(';')
        data2_file.close()
    except:
        print('Error al escribir archivo data2.dat')
    #Crear data0.dat
    try:
        data0_file = open('data0.dat','w+')
        data0_file.write('param C := ' + str(n_clientes_dia[iter_dia-1] + n_atrasados_dia[iter_dia-1])+ ";\n")
        data0_file.write('param Lcap := ' + str(Lcap)+";\n")
        data0_file.write('param fleet_size := '+ str(fleet_size)+";\n")
        data0_file.write('param distanceCost :=  '+ str(costo_distancia)+";\n")
        data0_file.write('param delayCost :='+ str(costo_atraso)+";")
        data0_file.close()
    except:
        print('Error al escribir archivo data0.txt')

    #Crear data3.dat
    print('clientes normales = ',n_clientes_dia[iter_dia-1])
    print('clientes atrasados = ',n_atrasados_dia[iter_dia-1])
    col_file = open('all_cols.dat','r')
    all_cols = []
    for line in col_file.readlines():
        if line[:1] != '#':
            aux = line.split()
            if aux[0] == output_file:
                if (int(aux[1]) <= n_clientes_dia[iter_dia-1] + 3 and int(aux[2]) <= n_clientes_dia[iter_dia-1] + 3 and int(aux[3]) <= n_clientes_dia[iter_dia-1] + 3 and int(aux[4]) <= n_clientes_dia[iter_dia-1] + 3 and int(aux[5]) <= n_clientes_dia[iter_dia-1] + 3):
                    #Si la columna contiene un nodo ficticio, entonces se cambia el numero para que quede despues de los atrasados
                    if int(aux[1]) == n_clientes_dia[iter_dia-1] + 1 : aux[1] = str(n_clientes_dia[iter_dia-1] + n_atrasados_dia[iter_dia-1] + 1)
                    if int(aux[2]) == n_clientes_dia[iter_dia-1] + 1 : aux[2] = str(n_clientes_dia[iter_dia-1] + n_atrasados_dia[iter_dia-1] + 1)
                    if int(aux[3]) == n_clientes_dia[iter_dia-1] + 1 : aux[3] = str(n_clientes_dia[iter_dia-1] + n_atrasados_dia[iter_dia-1] + 1)
                    if int(aux[4]) == n_clientes_dia[iter_dia-1] + 1 : aux[4] = str(n_clientes_dia[iter_dia-1] + n_atrasados_dia[iter_dia-1] + 1)
                    if int(aux[5]) == n_clientes_dia[iter_dia-1] + 1 : aux[5] = str(n_clientes_dia[iter_dia-1] + n_atrasados_dia[iter_dia-1] + 1)
                    if int(aux[1]) == n_clientes_dia[iter_dia-1] + 2 : aux[1] = str(n_clientes_dia[iter_dia-1] + n_atrasados_dia[iter_dia-1] + 2)
                    if int(aux[2]) == n_clientes_dia[iter_dia-1] + 2 : aux[2] = str(n_clientes_dia[iter_dia-1] + n_atrasados_dia[iter_dia-1] + 2)
                    if int(aux[3]) == n_clientes_dia[iter_dia-1] + 2 : aux[3] = str(n_clientes_dia[iter_dia-1] + n_atrasados_dia[iter_dia-1] + 2)
                    if int(aux[4]) == n_clientes_dia[iter_dia-1] + 2 : aux[4] = str(n_clientes_dia[iter_dia-1] + n_atrasados_dia[iter_dia-1] + 2)
                    if int(aux[5]) == n_clientes_dia[iter_dia-1] + 2 : aux[5] = str(n_clientes_dia[iter_dia-1] + n_atrasados_dia[iter_dia-1] + 2)
                    if int(aux[1]) == n_clientes_dia[iter_dia-1] + 3 : aux[1] = str(n_clientes_dia[iter_dia-1] + n_atrasados_dia[iter_dia-1] + 3)
                    if int(aux[2]) == n_clientes_dia[iter_dia-1] + 3 : aux[2] = str(n_clientes_dia[iter_dia-1] + n_atrasados_dia[iter_dia-1] + 3)
                    if int(aux[3]) == n_clientes_dia[iter_dia-1] + 3 : aux[3] = str(n_clientes_dia[iter_dia-1] + n_atrasados_dia[iter_dia-1] + 3)
                    if int(aux[4]) == n_clientes_dia[iter_dia-1] + 3 : aux[4] = str(n_clientes_dia[iter_dia-1] + n_atrasados_dia[iter_dia-1] + 3)
                    if int(aux[5]) == n_clientes_dia[iter_dia-1] + 3 : aux[5] = str(n_clientes_dia[iter_dia-1] + n_atrasados_dia[iter_dia-1] + 3)
                    a = aux[1] + "\t"+ aux[2]+"\t"+aux[3]+"\t"+aux[4]+"\t"+aux[5]
                    all_cols.append(a)
    col_file.close()


    data3_file = open('data3.dat','w+')
    data3_file.write('param n_cols := ' +str(len(all_cols)) + ';\n')
    data3_file.write('param col_ini : 1 2 3 4 5 :=\n')
    cuenta = 0
    colstart=len(output_file)
    for c in all_cols:
        cuenta = cuenta + 1
        data3_file.write(str(cuenta) + '\t' + c + '\n')
    data3_file.write(";")
    data3_file.close()




    #Eliminamos los logs anteriores si existen


    #Escribe el archivo de ejecucción actualizado
    write_runWeek(model_path, output_file, log_file)

    #Ejecuta el modelo

    model_command = './ampl '+model_path+'run_week.run"'
    print(model_command)
    p = subprocess.call(model_command, cwd = ampl_path, shell = True)

    #Obtener clientes pendientes
    id_clientes_pendientes = []
    try:
        salida_file = open(output_file,'r')
        all_lines = salida_file.readlines()
        iter_line = iter(all_lines)
        for line in iter_line:
            if line[:3] == 'vi[':
                line= next(iter_line)
                while line[:1] != ';':
                    a = line.split()
                    id_clientes_pendientes.append(a[0])
                    line= next(iter_line)
    except:
        print('Error al leer el archivo '+output_file)

    #Imprimimos la lista de clientes pendientes
    print(id_clientes_pendientes)
    total_clientes_pendientes = len(id_clientes_pendientes)
    print('CLIENTES SIN ATENDER ' +str(total_clientes_pendientes))
    #Actualizar el estatus de los clientes pendenties
    for c in id_clientes_pendientes:
        for i in clientes:
            if int(c) == i.model_id and i.dia == iter_dia:
                i.dia = -(iter_dia+1)
                i.penalty = 2*i.penalty

    #Backup de todos los archivos de datos
    shutil.copy2('data0.dat', 'backups/data0_'+str(iter_dia)+'.dat')
    shutil.copy2('data2.dat', 'backups/data2_'+str(iter_dia)+'.dat')
    shutil.copy2('data3.dat', 'backups/data3_'+str(iter_dia)+'.dat')


    t_fin  = time.time()

    f = open('tiempo.txt','a')
    inicio=time.strftime("%H:%M:%S%t%D",time.localtime(t_start))
    fin=time.strftime("%H:%M:%S%t%D",time.localtime(t_fin))
    delta=str(int(t_fin - t_start))
    f.write('Dia\t'+str(iter_dia)+'\nInicio\t'+inicio+'\nFin\t'+fin+'\nTotal\t'+delta+'\n\n')
    f.close()

    #Actualizamos el dia
    iter_dia = iter_dia +1
e_clientes = open('estado_final_clients.txt','w+')
try:
	e_clientes.write('#Nombre\tDiaAten\tModelId\t\tT.Servicio\tPenalty\n')
	for c in clientes:
		e_clientes.write(c.nombre + "\t" + str(c.dia) + "\t" + str(c.model_id) + "\t" + str(c.tiempo) + "\t" + str(c.penalty) +"\n")
except:
	print('error creando estado_final_clientes')
e_clientes.close()
