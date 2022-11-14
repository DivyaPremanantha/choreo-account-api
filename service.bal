import choreotestorganization/consentservice;
import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # A resource for generating consent
    # + return - consent response
    resource function post accountAccessConsent(string clientID, string clientSecret) returns string|error {
        if clientID is "" || clientSecret is "" {
            return error("client ID or client secret can not be empty!");
        }

        consentservice:Client consentserviceEp = check new (clientConfig = {
            auth: {
                clientId: clientID,
                clientSecret: clientSecret
            }
        });

        string getCreateAccountConsentResponse = check consentserviceEp->getCreateaccountconsent();
        return "Account Consent POST Service Invoked, Consent ID: " + getCreateAccountConsentResponse;
    }

    # A resource to return consent
    # + return - consent response
    resource function get accountAccessConsent(string clientID, string clientSecret) returns string|error {
        if clientID is "" || clientSecret is "" {
            return error("client ID or client secret can not be empty!");
        }
        return "Account Consent GET Service Invoked";
    }

    # A resource to return consent
    # + return - consent response
    resource function get accounts(string clientID, string clientSecret) returns string|error {
        if clientID is "" || clientSecret is "" {
            return error("client ID or client secret can not be empty!");
        }
        return "Account Service Invoked";
    }
}
