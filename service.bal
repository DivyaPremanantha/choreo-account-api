import choreotestorganization/accountservice;
import choreotestorganization/consentservice;
import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # A resource for generating consent
    # + return - consent response
    resource function post accountAccessConsent(string clientID, string clientSecret, @http:Payload json consentResource) returns json|error {
        if (!(clientID is "" || clientSecret is "")) {
            consentservice:Client consentserviceEp = check new (clientConfig = {
                auth: {
                    clientId: clientID,
                    clientSecret: clientSecret
                }
            });
            json postAccountconsentResponse = check consentserviceEp->postAccountconsent(payload = consentResource);
            return postAccountconsentResponse;
        } else {
            return error("client ID or client secret can not be empty!");
        }
    }

    # A resource to return consent
    # + return - consent response
    resource function get accountAccessConsent(string clientID, string clientSecret) returns json|error {
        if (!(clientID is "" || clientSecret is "")) {
            consentservice:Client consentserviceEp = check new (clientConfig = {
                auth: {
                    clientId: clientID,
                    clientSecret: clientSecret
                }
            });
            json getAccountconsentResponse = check consentserviceEp->getAccountconsent();
            return getAccountconsentResponse;
        } else {
            return error("client ID or client secret can not be empty!");
        }
    }

    # A resource to return consent
    # + return - consent response
    resource function get accounts(string clientID, string clientSecret) returns json|error {
        if (!(clientID is "" || clientSecret is "")) {
            accountservice:Client accountserviceEp = check new (clientConfig = {
                auth: {
                    clientId: clientID,
                    clientSecret: clientSecret
                }
            });
            json getAccountsResponse = check accountserviceEp->getAccounts();
            return getAccountsResponse;
        } else {
            return error("client ID or client secret can not be empty!");
        }
    }

    # A resource to return consent
    # + return - consent response
    resource function get transactions(string clientID, string clientSecret) returns json|error {
        if (!(clientID is "" || clientSecret is "")) {
            accountservice:Client accountserviceEp = check new (clientConfig = {
                auth: {
                    clientId: clientID,
                    clientSecret: clientSecret
                }
            });
            json getTransactionsResponse = check accountserviceEp->getTransactions();
            return getTransactionsResponse;
        } else {
            return error("client ID or client secret can not be empty!");
        }
    }
}
