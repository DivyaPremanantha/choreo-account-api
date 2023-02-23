import choreotestorganization/accountservice;
import choreotestorganization/consentservice;
import ballerina/http;

configurable string consentServiceClientID = ?;
configurable string consentServiceClientSecret = ?;
configurable string backendServiceClientID = ?;
configurable string backendServiceClientSecret = ?;
# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # The service to generate account consent resource.
    # + consentResource - Account consent payload.
    # + return - Consent resource.
    resource function post accountAccessConsent(@http:Payload json consentResource) returns json|error {
        if (!(consentServiceClientID is "" || consentServiceClientSecret is "")) {
            consentservice:Client consentserviceEp = check new (config = {
                auth: {
                    clientId: consentServiceClientID,
                    clientSecret: consentServiceClientSecret
                }
            });
            json postAccountconsentResponse = check consentserviceEp->postAccountconsent(payload = consentResource);
            return postAccountconsentResponse;
        } else {
            return error("client ID or client secret can not be empty!");
        }
    }

    # The service to return account consent resource
    # + return - Consent response.
    resource function get accountAccessConsent() returns json|error {
        if (!(consentServiceClientID is "" || consentServiceClientSecret is "")) {
            consentservice:Client consentserviceEp = check new (config = {
                auth: {
                    clientId: consentServiceClientID,
                    clientSecret: consentServiceClientSecret
                }
            });
            json getAccountconsentResponse = check consentserviceEp->getAccountconsent();
            return getAccountconsentResponse;
        } else {
            return error("{ error_code: 403, error_description: client ID or client secret can not be empty!}");
        }
    }

    # A service to return accounts resource.
    # + return - Account resource.
    resource function get accounts() returns json|error {
        if (!(backendServiceClientID is "" || backendServiceClientSecret is "")) {
            accountservice:Client accountserviceEp = check new (config = {
                auth: {
                    clientId: backendServiceClientID,
                    clientSecret: backendServiceClientSecret
                }
            });
            json getAccountsResponse = check accountserviceEp->getAccounts();
            return getAccountsResponse;
        } else {
            return error("client ID or client secret can not be empty!");
        }
    }

    # A service to return transaction resource.
    # + return - Transaction resource.
    resource function get transactions() returns json|error {
        if (!(backendServiceClientID is "" || backendServiceClientSecret is "")) {
            accountservice:Client accountserviceEp = check new (config = {
                auth: {
                    clientId: backendServiceClientID,
                    clientSecret: backendServiceClientSecret
                }
            });
            json getTransactionsResponse = check accountserviceEp->getTransactions();
            return getTransactionsResponse;
        } else {
            return error("client ID or client secret can not be empty!");
        }
    }
}
