#include "crow/http_response.h"
#include "database_common.h"
#include "database_connector.h"
#include "crow/common.h"
#include "global_variables.h"
#include "middleware.h"
#include "crypto.h"
#include "employee.h"
#include "tokens.h"
#include "permissions.h"

void AddEmployeePOSTRequests(crow::App<AUTH_MIDDLEWARE> &app)
{
    CROW_ROUTE(app, "/users/appraisals/create").methods(crow::HTTPMethod::POST)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::NONE_PERM, SUB_PERMISSIONS::NONE_SUBPERM)
         crow::json::rvalue body = crow::json::load(req.body);
         std::string title, description, givenTo, tempDate;
         double salaryEffect;
         try
         {
            title = body["title"].s();
            description = body["description"].s();
            givenTo = body["givenTo"].s();
            salaryEffect = body["salaryEffect"].d();
         }
         catch(const std::exception& e)
         {
            return crow::response(400, "bad request");
         }
         std::string employeeUUID = tokenInfo.GetUUID();
         std::string managerUUID = GetEmployeeManagerUUID(givenTo);
         if(managerUUID != employeeUUID)
            return crow::response(403, "forbidden");
         try
         {
            soci::session db(pool);
            db << CREATE_APPRAISAL_QUERY, soci::use(title), soci::use(description),
            soci::use(CHECK_NULLABILITY_DOUBLE(salaryEffect)),
            soci::use(givenTo), soci::use(managerUUID);
            return crow::response(201, "appraisal successfully created");
         }
         catch(const std::exception& e)
         {
            std::cerr << "DATABASE ERROR (/users/appraisals/create): " << e.what() << '\n';
            return crow::response(500, "database error");
         }
         });

    CROW_ROUTE(app, "/users/citations/create").methods(crow::HTTPMethod::POST)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::NONE_PERM, SUB_PERMISSIONS::NONE_SUBPERM)
         crow::json::rvalue body = crow::json::load(req.body);
         std::string title, description, givenTo, tempDate;
         double salaryEffect;
         try
         {
            title = body["title"].s();
            description = body["description"].s();
            givenTo = body["givenTo"].s();
            salaryEffect = body["salaryEffect"].d();
         }
         catch(const std::exception& e)
         {
            return crow::response(400, "bad request");
         }
         std::string employeeUUID = tokenInfo.GetUUID();
         std::string managerUUID = GetEmployeeManagerUUID(givenTo);
         if(managerUUID != employeeUUID)
            return crow::response(403, "forbidden");
         try
         {
            soci::session db(pool);
            db << CREATE_CITATION_QUERY, soci::use(title), soci::use(description),
            soci::use(CHECK_NULLABILITY_DOUBLE(salaryEffect)),
            soci::use(givenTo), soci::use(managerUUID);
            return crow::response(201, "citation successfully created");
         }
         catch(const std::exception& e)
         {
            std::cerr << "DATABASE ERROR (/users/citations/create): " << e.what() << '\n';
            return crow::response(500, "database error");
         }
         });

    CROW_ROUTE(app, "/jobs/create").methods(crow::HTTPMethod::POST)
        ([&](const crow::request& req)
         {
            AUTH_INIT(PERMISSIONS::JOBS, SUB_PERMISSIONS::CREATE_JOB)
            crow::json::rvalue body = crow::json::load(req.body);
            soci::session db(pool);
            std::string title = body["title"].s();
            std::string description = body["description"].s();
            if(title.empty() || description.empty())
                return crow::response(400, "invalid request");
            try
            {
            std::string uuid = GetUUIDv7();
            db << CREATE_JOB_QUERY, soci::use(uuid), soci::use(title), soci::use(description);
            }
            catch(const std::exception& e)
            {
                std::cerr << "DATABASE ERROR: " << e.what() << '\n';
                return crow::response(500, "database error");
            }
            return crow::response(201, "job created successfully");
         });

    CROW_ROUTE(app, "/users/create/employee").methods(crow::HTTPMethod::POST)
        ([&](const crow::request& req)
         {
            AUTH_INIT(PERMISSIONS::HUMAN_RESOURCES, SUB_PERMISSIONS::HIRE_EMPLOYEE)
            crow::json::rvalue jsonBody = crow::json::load(req.body);
            std::string firstName = jsonBody["firstName"].s();
            std::string middleName = jsonBody["middleName"].s();
            std::string lastName = jsonBody["lastName"].s();
            std::string gender = jsonBody["gender"].s();
            double salary = jsonBody["salary"].d();
            std::string departmentID = jsonBody["departmentID"].s();
            std::string jobID = jsonBody["jobID"].s();
            std::string managerID = jsonBody["managerID"].s();
            std::string tempManagerHireDate = jsonBody["managerHireDate"].s();
            std::tm managerHireDate;
            if(!strptime(tempManagerHireDate.c_str(), TIME_FORMAT_STRING, &managerHireDate))
                return crow::response(400, "invalid manager hire date");
            std::string id = GetUUIDv7();
         try
         {
            soci::session db(pool);
            db << CREATE_EMPLOYEE_QUERY, 
            soci::use(id), soci::use(firstName),
            soci::use(middleName, middleName.empty() ? NULL_INDICATOR : OK_INDICATOR),
            soci::use(lastName),
            soci::use(gender, gender.empty() ? NULL_INDICATOR : OK_INDICATOR),
            soci::use(salary),
            soci::use(departmentID, departmentID.size() ? NULL_INDICATOR : OK_INDICATOR),
            soci::use(jobID, jobID.size() ? NULL_INDICATOR : OK_INDICATOR),
            soci::use(managerID, managerID.size() ? NULL_INDICATOR : OK_INDICATOR),
            soci::use(managerHireDate, managerID.size() ? NULL_INDICATOR : OK_INDICATOR);
            return crow::response(201, "user successfully created");
         }
         catch(std::exception& e)
         {
            //to fix later
            std::cerr << "ERROR UNKNOWN: " << e.what() << '\n';
            return crow::response(400, "bad request or database error");
         }
         });

    CROW_ROUTE(app, "/departments/create").methods(crow::HTTPMethod::POST)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::HUMAN_RESOURCES, SUB_PERMISSIONS::ADD_DEPARTMENT)
         crow::json::rvalue body = crow::json::load(req.body);
         std::string departmentID = GetUUIDv7();
         try
         {
            std::string title = body["title"].s();
            std::string description = body["description"].s();
            std::string location = body["location"].s();
            uint8_t permission = body["permission"].i();
            unsigned long long subPermission = body["subPermission"].i(); 
            std::string managerID = body["managerID"].s();
            std::string tempManagerHireDate = body["managerHireDate"].s();
            std::tm managerHireDate;
            if(!strptime(tempManagerHireDate.c_str(), TIME_FORMAT_STRING, &managerHireDate))
                return crow::response(400, "invalid manager hire date");
         
            soci::session db(pool);
            db << CREATE_DEPARTMENT_QUERY, soci::use(departmentID), soci::use(title),
            soci::use(CHECK_NULLABILITY(description)), soci::use(location),
            soci::use(permission), soci::use(subPermission),
            soci::use(CHECK_NULLABILITY(managerID)),
            soci::use(managerHireDate, managerID.size() ? NULL_INDICATOR : OK_INDICATOR );
            return crow::response(201, "department successfully created");
         }
         
         catch(const std::exception& e)
         {
            //To fix later
            std::cerr << e.what() << '\n';
            return crow::response(400, "bad request or database error");
         }
         });

    CROW_ROUTE(app, "/users/tasks/create").methods(crow::HTTPMethod::POST)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::NONE_PERM, SUB_PERMISSIONS::NONE_SUBPERM)
         std::string creatorUUID = tokenInfo.GetUUID();
         std::string title, description, tempDeadline, assignedEmployee;
         std::tm deadline;
         try
         {
            const crow::json::rvalue body = crow::json::load(req.body);
            title = body["title"].s();
            description = body["description"].s();
            tempDeadline = body["deadline"].s();
            assignedEmployee = body["assignedEmployee"].s();
         }
         catch(const std::exception& e)
         {
            std::cerr << "BAD REQUEST(/user/tasks/create): " << e.what() << '\n';
            return crow::response(400, "bad request");
         }
         //Make sure the employee is authorized (is manager of employee) to give tasks to assignedEmployee
         /*std::cout << "CREATOR UUID: "<<  creatorUUID << '\n';
         std::cout << "MANAGER UUID: " << GetEmployeeManagerUUID(assignedEmployee) << '\n'; 
         std::cout << "ASSIGNED EMPLOYEE: " << assignedEmployee << '\n';*/
         if(creatorUUID != GetEmployeeManagerUUID(assignedEmployee))
            return crow::response(403, "forbidden");

         if(!strptime(tempDeadline.c_str(), TIME_FORMAT_STRING, &deadline))
            return crow::response(400, "invalid deadline");
         
         soci::session db(pool);
         db << CREATE_TASK_QUERY, soci::use(title), soci::use(description), soci::use(deadline),
         soci::use(assignedEmployee), soci::use(creatorUUID);
         return crow::response(200, "task created successfully");
         });
}
