public with sharing class WeatherService {

    @AuraEnabled
    public static String getWeather(String city) {

        if(String.isBlank(city)){
            return 'Please enter a city name';
        }

        Http http = new Http();
        HttpRequest req = new HttpRequest();

      String endpoint = 'callout:Weather_API/v1/current.json?key=0d111258d4844249a0b110744262703&q=' + city;

        req.setEndpoint(endpoint);
        req.setMethod('GET');

        try {
            HttpResponse res = http.send(req);

            if(res.getStatusCode() == 200){
                return res.getBody();
            } else {
                return 'Error: ' + res.getStatus();
            }
        } catch (Exception e) {
    return 'Error: ' + e.getMessage();
}
    }
}