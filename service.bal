import choreotestorganization/accountservice;
import choreotestorganization/consentservice;
import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # The service to generate account consent resource.
    # + clientID - Client ID of the consent servie.
    # + clientSecret - Client Secret of the consent servie.
    # + consentResource - Acoount consent payload.
    # + return - Consent resource.
    resource function post accountAccessConsent(string consentServiceClientID, string consentServiceClientSecret, @http:Payload json consentResource) returns json|error {
        if (!(consentServiceClientID is "" || consentServiceClientSecret is "")) {
            consentservice:Client consentserviceEp = check new (clientConfig = {
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
    # + consentServiceClientID - Client ID of the consent servie.
    # + consentServiceClientSecret - Client Secret of the consent servie.
    # + return - Consent response.
    resource function get accountAccessConsent(string consentServiceClientID, string consentServiceClientSecret) returns json|error {
        if (!(consentServiceClientID is "" || consentServiceClientSecret is "")) {
            consentservice:Client consentserviceEp = check new (clientConfig = {
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
    # + backendServiceClientID - Client ID of the bank backend servie.
    # + backendServiceClientSecret - Client Secret of the bank backend servie.
    # + return - Account resource.
    resource function get accounts(string backendServiceClientID, string backendServiceClientSecret) returns json|error {
        if (!(backendServiceClientID is "" || backendServiceClientSecret is "")) {
            accountservice:Client accountserviceEp = check new (clientConfig = {
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
    # + backendServiceClientID - Client ID of the bank backend servie.
    # + backendServiceClientSecret - Client Secret of the bank backend servie.
    # + return - Transaction resource.
    resource function get transactions(string backendServiceClientID, string backendServiceClientSecret) returns json|error {
        if (!(backendServiceClientID is "" || backendServiceClientSecret is "")) {
            accountservice:Client accountserviceEp = check new (clientConfig = {
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
