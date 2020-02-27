Accounting for cost heterogeneity on the demand in the context of a technician dispatching problem


Implementation of a Technitcian Dispatch Problem using AMPL and Python
Departamento de Ingeniería Industrial - Universidad de Chile

These codes implement the Technitcian Dispatch Problem described in the Paper "Accounting for cost heterogeneity on the demand in the context of a technician dispatching problem" using AMPL, CPLEX and Python. In order to run these codes you will need these software and there respective licenses.

In this implementation, the problem is run iterative for a workweek (5 days), each day customers that weren't services are postponed for the next day, a penalty fee is paid and his priority is increased. The objective function minimizes the tradeoff betweed operational cost and the penalty fee. 

In the Instances Folder you will find some different cost configurations for the same group of customers. The model files and scrips are all included in the VRP folder.


**INSTRUCTIONS**
0. Be sure that you have AMPL with CPLEX and ilogcp solvers installed. You will also need python version 2.7 or 3+
1. Download or clone the VRP folder, this contains all the model files and scripts.  
2. In you local copy of the VRP folder you need to create a new folder named "backups"
3. Open with a text editor the file "Runner.py" and change the paths for the AMPL and the model.
3a. You can also edit here the size of the fleet parameters for each day changing the values of the array 
   fleet_size = [20,20,20,20,20]

4. Depending on you OS you may need to also open the "prob.run" file and change the following lines:
   option solver './cplex'; -> option solver 'cplex'; (windows)
   option solver './ilogcp'; -> option solver 'ilogcp'; (windows)

5. The instance file is called "alldata.txt", there is a demostration file already included in the VRP folder, you only need to overwrite it with the instance you want to run.
6. After running the model (may take a while), the output files will be created in the folder.
  
 Optional: if you want to provide a set of starting columns for each day you may do so in the file "allcols.dat"
