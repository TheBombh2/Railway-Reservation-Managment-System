#include "crow/common.h"
#include "employee.h"
#include "middleware.h"
#include "permissions.h"
#include "database_connector.h"

void AddEmployeeDELETERequests(crow::App<AUTH_MIDDLEWARE> &app)
{
    CROW_ROUTE(app, "/employee/<string>/delete").methods(crow::HTTPMethod::DELETE)
        ([&](const crow::request& req, const std::string& employeeUUID)
         {
         AUTH_INIT(PERMISSIONS::HUMAN_RESOURCES, SUB_PERMISSIONS::FIRE_EMPLOYEE)
         try
         {
            soci::session db(pool);
            std::string employeeName;
            db << GET_EMPLOYEE_NAME, soci::use(employeeUUID), soci::into(employeeName);
            if(employeeName.empty())
                return crow::response(404, "not found");
            soci::transaction trans(db);
            db << DELETE_EMPLOYEE_SECURITY_INFORMATION, soci::use(employeeUUID);
            db << DELETE_EMPLOYEE_PREVIOUS_PASSWORDS, soci::use(employeeUUID);
            db << DELETE_EMPLOYEE_CONTACT_INFORMATION, soci::use(employeeUUID);
            db << SET_EMPLOYEE_MANAGERS_TO_NULL, soci::use(employeeUUID);
            db << SET_DEPARTMENT_MANGERS_TO_NULL, soci::use(employeeUUID);
            trans.commit();
         }
         catch(const std::exception& e)
         {
            std::cerr << "DATABASE ERROR (/employee/<string>/delete): " << e.what() << '\n';
            return crow::response(500, "database error");
         }
         return crow::response(204, "employee successfully deleted");
         });

    CROW_ROUTE(app, "/departments/<string>/delete").methods(crow::HTTPMethod::DELETE)
        ([&](const crow::request& req, const std::string departmentUUID)
         {
         AUTH_INIT(PERMISSIONS::HUMAN_RESOURCES, SUB_PERMISSIONS::DELETE_DEPARTMENT)
         soci::session db(pool);
         std::string departmentTitle;
         try
         {
            db << GET_DEPARTMENT_TITLE_QUERY, soci::use(departmentUUID), soci::into(departmentTitle);
            if(departmentTitle.empty())
                return crow::response(404, "not found");
            db << DELETE_DEPARTMENT_QUERY, soci::use(departmentUUID);
         }
         catch(const std::exception& e)
         {
            std::cerr << "DATABASE ERROR (/departments/<string>/delete): " << e.what() << '\n';
            std::cerr << "<string> value: " << departmentUUID << '\n';
            return crow::response(500, "database error");
         }
         return crow::response(204, "department successfully deleted");
         });
}
