#include <cstddef>
#include <soci/mysql/soci-mysql.h>
#include <soci/session.h>
#include <soci/soci-backend.h>
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
         AUTH_INIT(PERMISSIONS::HUMAN_RESOURCES, SUB_PERMISSIONS::VIEW_JOB)
         crow::json::wvalue returnBody;
         std::vector<std::string> titles(MAX_DEPARTMENTS_RETURNED);
         std::vector<std::string> descriptions(MAX_DEPARTMENTS_RETURNED);
         std::vector<std::string> locations(MAX_DEPARTMENTS_RETURNED);
         soci::session db(pool);
         db << GET_DEPARTMENTS_QUERY, soci::into(titles), soci::into(descriptions), soci::into(locations);
         returnBody["size"] = titles.size();
         for(unsigned int i = 0; i < titles.size(); i++)
         {
             returnBody["departments"][i]["title"] = titles[i];
             returnBody["departments"][i]["description"] = descriptions[i];
             returnBody["departments"][i]["location"] = locations[i];
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

    CROW_ROUTE(app, "/users/tasks").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::NONE_PERM, SUB_PERMISSIONS::NONE_SUBPERM)
         std::string uuid = tokenInfo.GetUUID();
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
}
