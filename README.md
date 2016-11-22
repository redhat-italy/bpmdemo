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
the first process is a very simple process that can be designed on the fly during the first part of the demo. 
### The PAYSLIP process
The payslip process must be imported and is based on a specific path of actions
