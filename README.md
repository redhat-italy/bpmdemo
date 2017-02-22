# bpmdemo
## A simple web application controlling a process
This demo is based on two simple processes (descripted below) defined by the Business Central and a web application which
interacts with them.
The web app can be deployed in the same container of the Business Central so that it can share the BC Realm. Configuring the
Web App security with the same Realm of the Business Central enables the SSo between the two contexts.
An example of Application Roles mapping file is provided in order to define the roles required by the second process.
### Demo overview
The demo is based on two different phases, one first phase has the purpose of showing the features of the centralized web console
(the Business central) and a second phase that describes how external applications can be integrated with processes
defined into the Business Central. The first phase can be self-managed and anyone can be free of performing it in the preferred flavour.
For the second phase a specific process, the web app and a specific set of users are required. The main purpose of this second part
of the demo is to demonstrate:
1. Interaction with the Business Central from an external app (using ReST API);
2. Use of groups, assignement and escalation of the Runtime Engine.
### The SIMPLE process
The first process is a very simple process that can be designed on the fly during the first part of the demo. 
### The PAYSLIP process
The payslip process must be imported and is based on a specific path of actions
### Setup
1. Install a BPM Suite platform following the product installation guide.
2. Clone this git project into a folder of your convenience. Let's call it **prj_dir**.
3. Run the BPMS instance.
4. Import the repository:
  1. Enter the console with a user with Admin role.
  2. Go to Authoring -> Administration.
  3. from the Repositories tab select Clone repository.
  4. Specify a name, select an OU of your preference and specify the path: **prj_dir**/repositories/mef
  5. The process *attivazioneSistemaPaghe* will be now available in the Project authoring section of the console.
5. Build the project so that now you have a precess definition of the above process in the process definition list.
6. Edit the web application (in the application folder of the cloned project) with your IDE.
7. Edit the **index.jsp** page and change the **theUrl** variable in the script section at the bottom of the file.
You have to change the references to the deployed processes: _/business-central/rest/runtime/**it.mef.demo:bpmdemo:1.0**/withvars/process/**bpmdemo.simple**/start_
by substituting it with correct ones that you can read from the console when you edit the process definition with the process editor.
8. Build the project using mvn clean package.
9. Deploy the app located in the target subfolder by copying it in the deployments dir or using the web administration console or using the deploy command of the CLI.
