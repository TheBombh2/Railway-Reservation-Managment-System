#include <vector>
#include "crow/common.h"
#include "crow/http_response.h"
#include "database_common.h"
#include "database_connector.h"
#include "employee.h"
#include "middleware.h"
#include "misc_functions.h"
#include "permissions.h"

void AddEmployeeGETRequests(crow::App<AUTH_MIDDLEWARE> &app)
{
    CROW_ROUTE(app, "/users/<string>/appraisals").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req, const std::string& uuidRequest)
         {
         AUTH_INIT(PERMISSIONS::NONE_PERM, SUB_PERMISSIONS::NONE_SUBPERM)
         std::vector<std::string> titles(MAX_APPRAISALS_RETURNED);
         std::vector<std::string> descriptions(MAX_APPRAISALS_RETURNED);
         std::vector<std::tm> issueDate(MAX_APPRAISALS_RETURNED);
         std::vector<double> salaryImprovement(MAX_APPRAISALS_RETURNED);
         std::vector<std::string> managerFirstName(MAX_APPRAISALS_RETURNED);
         std::vector<std::string> managerLastName(MAX_APPRAISALS_RETURNED);
         std::vector<soci::indicator> salaryInds(MAX_APPRAISALS_RETURNED);
         std::string uuidToken = tokenInfo.GetUUID();
         if(uuidToken != uuidRequest)
            return crow::response(403, "forbidden");
         try
         {
            soci::session db(pool);
            db << GET_APPRAISALS_QUERY, soci::into(titles), soci::into(descriptions), soci::into(issueDate),
            soci::into(salaryImprovement, salaryInds), soci::into(managerFirstName),
            soci::into(managerLastName), soci::use(uuidToken);
         }
         catch(const std::exception& e)
         {
            std::cerr << "DATABASE ERROR(/users/<string>/appraisals): " << e.what() << '\n';
            return crow::response(500, "database error");
         }
         crow::json::wvalue result;
         result["size"] = titles.size();
         for(unsigned int i = 0; i < titles.size(); i++)
         {
            result["appraisals"][i]["title"] = titles[i];
            result["appraisals"][i]["description"] = descriptions[i];
            result["appraisals"][i]["managerFirstName"] = managerFirstName[i];
            result["appraisals"][i]["managerLastName"] = managerLastName[i];
            result["appraisals"][i]["issueDate"] = FormatTimeToString(issueDate[i]);
            if(salaryInds[i] == soci::indicator::i_ok) 
                result["appraisals"][i]["salaryImprovement"] = salaryImprovement[i];
            else 
                result["appraisals"][i]["salaryImprovement"] = 0.0;
         }
         return crow::response(200, result);
         });

    CROW_ROUTE(app, "/users/<string>/citations").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req, const std::string& uuidRequest)
         {
         AUTH_INIT(PERMISSIONS::NONE_PERM, SUB_PERMISSIONS::NONE_SUBPERM)
         std::vector<std::string> titles(MAX_CITATIONS_RETURNED);
         std::vector<std::string> descriptions(MAX_CITATIONS_RETURNED);
         std::vector<std::tm> issueDate(MAX_CITATIONS_RETURNED);
         std::vector<double> salaryDeduction(MAX_CITATIONS_RETURNED);
         std::vector<soci::indicator> salaryInds;
         std::vector<std::string> managerFirstName(MAX_CITATIONS_RETURNED);
         std::vector<std::string> managerLastName(MAX_CITATIONS_RETURNED);
         std::string uuidToken = tokenInfo.GetUUID();
         if(uuidToken != uuidRequest)
            return crow::response(403, "forbidden");
         try
         {
            soci::session db(pool);
            db << GET_CITATIONS_QUERY, soci::into(titles), soci::into(descriptions), soci::into(issueDate),
            soci::into(salaryDeduction, salaryInds), soci::into(managerFirstName),
            soci::into(managerLastName), soci::use(uuidToken);
         }
         catch(const std::exception& e)
         {
            std::cerr << "DATABASE ERROR(/users/<string>/citations): " << e.what() << '\n';
            return crow::response(500, "database error");
         }
         crow::json::wvalue result;
         result["size"] = titles.size();
         for(unsigned int i = 0; i < titles.size(); i++)
         {
            result["citations"][i]["title"] = titles[i];
            result["citations"][i]["description"] = descriptions[i];
            result["citations"][i]["managerFirstName"] = managerFirstName[i];
            result["citations"][i]["managerLastName"] = managerLastName[i];
            result["citations"][i]["issueDate"] = FormatTimeToString(issueDate[i]);
            if(salaryInds[i] == soci::indicator::i_ok) 
                result["citations"][i]["salaryDeduction"] = salaryDeduction[i];
            else 
                result["citations"][i]["salaryDeduction"] = 0.0;
         }
         return crow::response(200, result);
         });

    CROW_ROUTE(app, "/users/<string>/employee/salt").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req, const std::string& uuidInput)
         {
         AUTH_INIT(PERMISSIONS::NONE_PERM, SUB_PERMISSIONS::NONE_SUBPERM)
         std::string uuid = tokenInfo.GetUUID();
         if(uuidInput != uuid)
            return crow::response(403, "forbidden");
         std::string salt;
         soci::indicator ind;
         soci::session db(pool);
         db << GET_EMPLOYEE_SALT_QUERY, soci::use(uuid), soci::into(salt, ind);
         if(ind != soci::indicator::i_ok)
            return crow::response(404, "not found");
         return crow::response(200, salt);
         });

    CROW_ROUTE(app, "/departments/info").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::HUMAN_RESOURCES, SUB_PERMISSIONS::VIEW_DEPARTMENT)
         crow::json::wvalue returnBody;
         std::vector<std::string> titles(MAX_DEPARTMENTS_RETURNED);
         std::vector<std::string> descriptions(MAX_DEPARTMENTS_RETURNED);
         std::vector<std::string> locations(MAX_DEPARTMENTS_RETURNED);
         std::vector<std::string> ids(MAX_DEPARTMENTS_RETURNED);
         soci::session db(pool);
         db << GET_DEPARTMENTS_QUERY, soci::into(titles), soci::into(descriptions), soci::into(locations),
         soci::into(ids);
         returnBody["size"] = titles.size();
         for(unsigned int i = 0; i < titles.size(); i++)
         {
             returnBody["departments"][i]["title"] = titles[i];
             returnBody["departments"][i]["description"] = descriptions[i];
             returnBody["departments"][i]["location"] = locations[i];
             returnBody["departments"][i]["id"] = ids[i];
         }
         return crow::response(200, returnBody);
         }
         );

    CROW_ROUTE(app, "/jobs/<string>/info").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req, const std::string& uuid)
         {
         AUTH_INIT(PERMISSIONS::JOBS, SUB_PERMISSIONS::VIEW_JOB)
         soci::indicator ind;
         soci::session db(pool);
         std::string title, description;
         db << GET_JOB_INFO_QUERY, soci::use(uuid), soci::into(title, ind), soci::into(description);
         if(ind == soci::indicator::i_null)
            return crow::response(404, "not found");
         crow::json::wvalue result;
         result["title"] = title;
         result["description"] = description;
         return crow::response(200, result);
         });

    CROW_ROUTE(app, "/jobs/all-info").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::JOBS, SUB_PERMISSIONS::VIEW_JOB)
         std::vector<std::string> ids(MAX_JOBS_RETURNED), titles(MAX_JOBS_RETURNED);
         try
         {
            soci::session db(pool);
            db << GET_JOB_TITLES_AND_IDS_QUERY, soci::into(ids), soci::into(titles);
         }
         catch(const std::exception& e)
         {
            std::cerr << "DATABASE ERROR (/jobs/all-info): " << e.what() << '\n';
            return crow::response(500, "database error");
         }

         crow::json::wvalue result;
         result["size"] = ids.size();
         for(unsigned int i = 0; i < ids.size(); i++)
         {
            result["jobs"][i]["title"] = titles[i];
            result["jobs"][i]["id"] = ids[i];
         }
         return crow::response(200, result);
         });

    CROW_ROUTE(app, "/users/tasks").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::NONE_PERM, SUB_PERMISSIONS::NONE_SUBPERM)
         std::string uuid = tokenInfo.GetUUID();
         std::cout << "UUID IS: " << uuid << '\n';
         std::cout << tokenInfo.GetData() << '\n';
         std::vector<std::string> titles(MAX_TASKS_RETURNED);
         std::vector<std::string> descriptions(MAX_TASKS_RETURNED);
         std::vector<std::string> creatorEmployees(MAX_TASKS_RETURNED);
         std::vector<std::tm> completionDates(MAX_TASKS_RETURNED);
         std::vector<soci::indicator> completionDateIndicators(MAX_TASKS_RETURNED);
         std::vector<std::tm> deadlines(MAX_TASKS_RETURNED);
         std::vector<std::string> managerFirstNames(MAX_TASKS_RETURNED);
         std::vector<std::string> managerLastNames(MAX_TASKS_RETURNED);
         soci::session db(pool);
         db << GET_TASKS_QUERY, soci::use(uuid), soci::into(titles), soci::into(descriptions),
         soci::into(deadlines), soci::into(completionDates, completionDateIndicators),
         soci::into(managerFirstNames), soci::into(managerLastNames);
         crow::json::wvalue result;
         result["size"] = titles.size();
         for(unsigned int i = 0; i < titles.size(); i++)
         {
            result["tasks"][i]["title"] = titles[i];
            result["tasks"][i]["description"] = descriptions[i];
            result["tasks"][i]["managerFirstName"] = managerFirstNames[i];
            result["tasks"][i]["managerLastName"] = managerLastNames[i];
            result["tasks"][i]["deadline"] = FormatTimeToString(deadlines[i]);
            result["tasks"][i]["completionDate"] = 
             completionDateIndicators[i] == soci::indicator::i_ok ? FormatTimeToString(completionDates[i]) : "N/A";
         }
         return crow::response(200, result);
         });

    CROW_ROUTE(app, "/users/employee/all-info").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::NONE_PERM, SUB_PERMISSIONS::NONE_SUBPERM)
         std::string employeeID = tokenInfo.GetUUID();
         std::string employeeFirstName, employeeMiddleName, employeeLastName, 
         employeeGender, employeePhoneNumber, employeeEmail;
         double employeeSalary = 0.0;
         std::string departmentID, jobID, managerID;
         std::tm managerHireDate = GetEmptyTMObject();
         std::string jobTitle, jobDescription;
         std::string managerFirstName, managerMiddleName, managerLastName, managerGender,
         managerJobTitle, managerJobDescription;
         std::tm depManagerHiringDate = GetEmptyTMObject();
         std::string depTitle, depDescription, depLocation, depManagerFirstName, depManagerMiddleName,
         depManagerLastName, depManagerGender;
         //Be prepared little session, we are going to need you a lot
         soci::session db(pool); 
         try
         {
            //Info to get:
            //Job, Manager, Department
            soci::indicator jobIDInd, managerIDInd, departmentIDInd;
            db << GET_ALL_IDS_QUERY, soci::use(employeeID), soci::into(departmentID, departmentIDInd),
            soci::into(jobID, jobIDInd), soci::into(managerID, managerIDInd), soci::into(managerHireDate);

            //Info to get:
            //Job title, job description
            if(jobIDInd != NULL_INDICATOR)
            {
                db << GET_JOB_INFO_QUERY, soci::into(jobTitle), soci::into(jobDescription)
                , soci::use(CHECK_NULLABILITY(jobID));
            }

            //Info to get:
            //Manager First Name, Manager Middle name, Manager Last Name
            //Manager Job Title, Manager Job Description
            if(managerIDInd != NULL_INDICATOR)
            {
                soci::indicator managerMiddleNameInd;
                db << GET_MANAGER_INFORMATION_QUERY, soci::into(managerFirstName),
                soci::into(managerMiddleName, managerMiddleNameInd),
                soci::into(managerLastName), soci::into(managerGender), soci::into(managerJobTitle),
                soci::into(managerJobDescription), soci::use(managerID);
            }
            
            //Info to get:
            //Department title, department description, department location,
            //Department manager hiring date, department manager first name,
            //department manager middle name, department manager last name,
            //department manager gender
            if(departmentIDInd != NULL_INDICATOR)
            {
                db << GET_DEPARTMENT_INFORMATION_QUERY, soci::into(depTitle), soci::into(depDescription),
                soci::into(depLocation), soci::into(depManagerHiringDate), soci::into(depManagerFirstName),
                soci::into(depManagerMiddleName), soci::into(depManagerLastName), soci::into(depManagerGender),
                soci::use(departmentID);
            }

            //Info to get:
            //Employee firstName, employee middle name, employee last name, employee gender,
            //employee salary, employee email, employee phone number
            soci::indicator employeeMiddleNameInd;
            db << GET_EMPLOYEE_INFORMATION_QUERY, soci::use(employeeID),
            soci::into(employeeFirstName), soci::into(employeeMiddleName, employeeMiddleNameInd),
            soci::into(employeeLastName),
            soci::into(employeeGender), soci::into(employeeSalary), soci::into(employeePhoneNumber),
            soci::into(employeeEmail);
         }
         catch(const std::exception& e)
         {
            std::cerr << "DATABASE ERROR (/users/employee/all-info): " << e.what() << '\n';
            return crow::response(500, "database error");
         }
         //Now, we will very carefully an painfully construct a response taking into account
         //optional parameters.
         crow::json::wvalue result;
         result["basic-info"]["firstName"] = employeeFirstName;
         result["basic-info"]["middleName"] = employeeMiddleName;
         result["basic-info"]["lastName"] = employeeLastName;
         result["basic-info"]["salary"] = employeeSalary;
         result["basic-info"]["gender"] = employeeGender;

         result["job-info"]["jobTitle"] = jobTitle;
         result["job-info"]["jobDescription"] = jobDescription;

         result["department-info"]["title"] = depTitle;
         result["department-info"]["description"] = depDescription;
         result["department-info"]["location"] = depLocation;
         result["department-info"]["manager-info"]["managerHireDate"] = VERIFY_TIME(depManagerHiringDate);
         result["department-info"]["manager-info"]["firstName"] = depManagerFirstName;
         result["department-info"]["manager-info"]["middleName"] = depManagerMiddleName;
         result["department-info"]["manager-info"]["lastName"] = depManagerLastName;
         result["department-info"]["manager-info"]["gender"] = depManagerGender;

         result["manager-info"]["firstName"] = managerFirstName;
         result["manager-info"]["middleName"] = managerMiddleName;
         result["manager-info"]["lastName"] = managerLastName;
         result["manager-info"]["gender"] = managerGender;
         result["manager-info"]["job-info"]["jobTitle"] = managerJobTitle;
         result["manager-info"]["job-info"]["jobDescription"] = managerJobDescription;

         return crow::response(200, result);
         });

    CROW_ROUTE(app, "/users/employees/all-info").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::HUMAN_RESOURCES, SUB_PERMISSIONS::VIEW_EMPLOYEE)
         soci::session db(pool);
         std::vector<soci::indicator> employeeMiddleNameInds(MAX_EMPLOYEES_RETURNED);
         std::vector<soci::indicator> managerMiddleNameInds(MAX_EMPLOYEES_RETURNED);
         std::vector<std::string> employeeFirstNames(MAX_EMPLOYEES_RETURNED), employeeMiddleNames(MAX_EMPLOYEES_RETURNED),
         employeeLastNames(MAX_EMPLOYEES_RETURNED), employeeGenders(MAX_EMPLOYEES_RETURNED),
         employeeIDs(MAX_EMPLOYEES_RETURNED), managerFirstNames(MAX_EMPLOYEES_RETURNED),
         managerMiddleNames(MAX_EMPLOYEES_RETURNED), managerLastNames(MAX_EMPLOYEES_RETURNED),
         employeeJobTitles(MAX_EMPLOYEES_RETURNED),
         employeeEmails(MAX_EMPLOYEES_RETURNED), employeePhoneNumbers(MAX_EMPLOYEES_RETURNED);

         try
         {
            soci::session db(pool);
            db << GET_ALL_EMPLOYEES_INFORMATION_QUERY, soci::into(employeeFirstNames),
            soci::into(employeeMiddleNames, employeeMiddleNameInds), soci::into(employeeLastNames),
            soci::into(employeeGenders), soci::into(employeeIDs), soci::into(managerFirstNames),
            soci::into(managerMiddleNames, managerMiddleNameInds), soci::into(managerLastNames),
         soci::into(employeeJobTitles), soci::into(employeePhoneNumbers), soci::into(employeeEmails);
         }
         catch(const std::exception& e)
         {
            std::cerr << "DATABASE ERROR(/users/employees/all-info): " << e.what() << '\n';
            return crow::response(500, "database error");
         }
         crow::json::wvalue result;
         result["size"] = employeeIDs.size();
         std::cout << "EMPLOYEE SIZE: " << '\n';
         for(unsigned int i = 0; i < employeeIDs.size(); i++)
         {
            result["employees"][i]["employeeFirstName"] = employeeFirstNames[i];
            result["employees"][i]["employeeMiddleName"] = employeeMiddleNames[i];
            result["employees"][i]["employeeLastName"] = employeeLastNames[i];
            result["employees"][i]["employeeGender"] = employeeGenders[i];
            result["employees"][i]["employeeID"] = employeeIDs[i];
            result["employees"][i]["managerFirstName"] = managerFirstNames[i];
            result["employees"][i]["managerMiddleName"] = managerMiddleNames[i];
            result["employees"][i]["managerLastName"] = managerLastNames[i];
            result["employees"][i]["jobTitle"] = employeeJobTitles[i];
            result["employees"][i]["phoneNumber"] = employeePhoneNumbers[i];
            result["employees"][i]["email"] = employeeEmails[i];
         }
         return crow::response(200, result);
         });


    CROW_ROUTE(app, "/users/<string>/employee/uuid").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req, const std::string& email)
         {
         AUTH_INIT(PERMISSIONS::NONE_PERM, SUB_PERMISSIONS::NONE_SUBPERM)
         std::string employeeUUID = GetEmployeeUUID(email);
         if(employeeUUID.empty())
            return crow::response(404, "not found");
         return crow::response(200, employeeUUID);
         });

    CROW_ROUTE(app, "/permissions/all-permissions").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::HUMAN_RESOURCES, SUB_PERMISSIONS::NONE_SUBPERM)
         crow::json::wvalue result;
         result["size"] = 8;
         result["permissions"][0]["name"] = "Human Resources";
         result["permissions"][0]["value"] = PERMISSIONS::HUMAN_RESOURCES;
         result["permissions"][1]["name"] = "Information Technology";
         result["permissions"][1]["value"] = PERMISSIONS::INFORMATION_TECHNOLOGY;
         result["permissions"][2]["name"] = "Asset Management";
         result["permissions"][2]["value"] = PERMISSIONS::ASSET_MANAGEMENT;
         result["permissions"][3]["name"] = "Train Management";
         result["permissions"][3]["value"] = PERMISSIONS::TRAIN_MANAGEMENT;
         result["permissions"][4]["name"] = "Maintenance";
         result["permissions"][4]["value"] = PERMISSIONS::MAINTENANCE;
         result["permissions"][5]["name"] = "Ticketing";
         result["permissions"][5]["value"] = PERMISSIONS::TICKETING;
         result["permissions"][6]["name"] = "Management";
         result["permissions"][6]["value"] = PERMISSIONS::MANAGEMENT;
         result["permissions"][7]["name"] = "Jobs Management";
         result["permissions"][7]["value"] = PERMISSIONS::JOBS;
         return crow::response(200, result);
         });

    CROW_ROUTE(app, "/subpermissions/all-subpermissions").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::HUMAN_RESOURCES, SUB_PERMISSIONS::NONE_SUBPERM)
         crow::json::wvalue result;
         result["size"] = 8;
         result["subPermissions"]["Human Resources"]["Fire Employee"] = SUB_PERMISSIONS::FIRE_EMPLOYEE;
         result["subPermissions"]["Human Resources"]["Hire Employee"] = SUB_PERMISSIONS::HIRE_EMPLOYEE;
         result["subPermissions"]["Human Resources"]["View Employee"] = SUB_PERMISSIONS::VIEW_EMPLOYEE;
         result["subPermissions"]["Human Resources"]["Edit Employee"] = SUB_PERMISSIONS::EDIT_EMPLOYEE;
         result["subPermissions"]["Human Resources"]["Add Department"] = SUB_PERMISSIONS::ADD_DEPARTMENT;
         result["subPermissions"]["Human Resources"]["Delete Department"] = SUB_PERMISSIONS::DELETE_DEPARTMENT;
         result["subPermissions"]["Human Resources"]["View Department"] = SUB_PERMISSIONS::VIEW_DEPARTMENT;
         result["subPermissions"]["Human Resources"]["Edit Department"] = SUB_PERMISSIONS::EDIT_DEPARTMENT;
         result["subPermissions"]["Human Resources"]["index"] = DEPARTMENT_IDS::DEP_HUMAN_RESOURCES;

         result["subPermissions"]["Information Technology"]["Change Password"] = SUB_PERMISSIONS::CHANGE_PASSWORD;
         result["subPermissions"]["Information Technology"]["View Ticket"] = SUB_PERMISSIONS::VIEW_TICKET;
         result["subPermissions"]["Information Technology"]["Reserve Resolve Ticket"] = SUB_PERMISSIONS::RESERVE_RESOLVE_TICKET;
         result["subPermissions"]["Information Technology"]["index"] = DEPARTMENT_IDS::DEP_INFORMATION_TECHNOLOGY;

         result["subPermissions"]["Asset Management"]["Purchase Asset"] = SUB_PERMISSIONS::PURCHASE_ASSET;
         result["subPermissions"]["Asset Management"]["Sell Asset"] = SUB_PERMISSIONS::SELL_ASSET;
         result["subPermissions"]["Asset Management"]["Edit Asset"] = SUB_PERMISSIONS::EDIT_ASSET;
         result["subPermissions"]["Asset Management"]["Add Asset"] = SUB_PERMISSIONS::ADD_ASSET;
         result["subPermissions"]["Asset Management"]["Delete Asset"] = SUB_PERMISSIONS::DELETE_ASSET;
         result["subPermissions"]["Asset Management"]["Create Maintenance"] = SUB_PERMISSIONS::CREATE_MAINTENANCE;
         result["subPermissions"]["Asset Management"]["index"] = DEPARTMENT_IDS::DEP_ASSET_MANAGEMENT;

         result["subPermissions"]["Train Management"]["View Train Location"] = SUB_PERMISSIONS::VIEW_TRAIN_LOCATION;
         result["subPermissions"]["Train Management"]["Update Train Location"] = SUB_PERMISSIONS::UPDATE_TRAIN_LOCATION;
         result["subPermissions"]["Train Management"]["Add Train"] = SUB_PERMISSIONS::ADD_TRAIN;
         result["subPermissions"]["Train Management"]["Edit Train"] = SUB_PERMISSIONS::EDIT_TRAIN;
         result["subPermissions"]["Train Management"]["Delete Train"] = SUB_PERMISSIONS::DELETE_TRAIN;
         result["subPermissions"]["Train Management"]["View Train Data"] = SUB_PERMISSIONS::VIEW_TRAIN_DATA;
         result["subPermissions"]["Train Management"]["Add Station"] = SUB_PERMISSIONS::ADD_STATION;
         result["subPermissions"]["Train Management"]["Delete Station"] = SUB_PERMISSIONS::DELETE_STATION;
         result["subPermissions"]["Train Management"]["index"] = DEPARTMENT_IDS::DEP_TRAIN_MANAGEMENT;

         result["subPermissions"]["Maintenance"]["View Maintenance Job"] = SUB_PERMISSIONS::VIEW_MAINTENANCE_JOB;
         result["subPermissions"]["Maintenance"]["Reserve Resolve Maintenance"] = SUB_PERMISSIONS::RESERVE_RESOLVE_MAINTENANCE;
         result["subPermissions"]["Maintenance"]["Create Maintenance Job"] = SUB_PERMISSIONS::CREATE_MAINTENANCE_JOB;
         result["subPermissions"]["Maintenance"]["View Maintenance Job"] = SUB_PERMISSIONS::VIEW_MAINTENANCE_JOB;
         result["subPermissions"]["Maintenance"]["Edit Maintenance Job"] = SUB_PERMISSIONS::EDIT_MAINTENANCE_JOB;
         result["subPermissions"]["Maintenance"]["index"] = DEPARTMENT_IDS::DEP_MAINTENANCE;

         result["subPermissions"]["Ticketing"]["Create Ticket"] = SUB_PERMISSIONS::CREATE_TICKET;
         result["subPermissions"]["Ticketing"]["Cancel Ticket"] = SUB_PERMISSIONS::CANCEL_TICKET;
         result["subPermissions"]["Ticketing"]["Verify Ticket"] = SUB_PERMISSIONS::VERIFY_TICKET;
         result["subPermissions"]["Ticketing"]["index"] = DEPARTMENT_IDS::DEP_TICKETING;

         result["subPermissions"]["Management"]["View Reports"] = SUB_PERMISSIONS::VIEW_REPORTS;
         result["subPermissions"]["Management"]["View Performance Statistsics"] = SUB_PERMISSIONS::VIEW_PERFORMANCE_STATISTICS;
         result["subPermissions"]["Management"]["index"] = DEPARTMENT_IDS::DEP_MANAGEMENT;

         result["subPermissions"]["Jobs"]["View Job"] = SUB_PERMISSIONS::VIEW_JOB;
         result["subPermissions"]["Jobs"]["Create Job"] = SUB_PERMISSIONS::CREATE_JOB;
         result["subPermissions"]["Jobs"]["Delete Job"] = SUB_PERMISSIONS::DELETE_JOB;
         result["subPermissions"]["Jobs"]["Edit Job"] = SUB_PERMISSIONS::EDIT_JOB;
         result["subPermissions"]["Jobs"]["index"] = DEPARTMENT_IDS::DEP_JOBS;
         return crow::response(200, result);
         });
}
