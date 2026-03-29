// public with sharing class WeatherService {

//     @AuraEnabled
//     public static String getWeather(String city) {

//         if(String.isBlank(city)){
//             return 'Please enter a city name';
//         }

//         Http http = new Http();
//         HttpRequest req = new HttpRequest();

//       String endpoint = 'callout:Weather_API/v1/current.json?key=0d111258d4844249a0b110744262703&q=' + city;

//         req.setEndpoint(endpoint);
//         req.setMethod('GET');

//         try {
//             HttpResponse res = http.send(req);

//             if(res.getStatusCode() == 200){
//                 return res.getBody();
//             } else {
//                 return 'Error: ' + res.getStatus();
//             }
//         } catch (Exception e) {
//     return 'Error: ' + e.getMessage();
// }
//     }
// }
public with sharing class WeatherService {

    @AuraEnabled
    public static Map<String, String> getWeather(String city) {

        Http http = new Http();
        HttpRequest req = new HttpRequest();

        String endpoint = 'callout:Weather_API/v1/current.json?key=0d111258d4844249a0b110744262703&q=' + city;

        req.setEndpoint(endpoint);
        req.setMethod('GET');

        HttpResponse res = http.send(req);

        if(res.getStatusCode() == 200){

            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());

            Map<String, Object> location = (Map<String, Object>) result.get('location');
            Map<String, Object> current = (Map<String, Object>) result.get('current');
            Map<String, Object> condition = (Map<String, Object>) current.get('condition');

            Map<String, String> response = new Map<String, String>();

            response.put('city', (String) location.get('name'));
            response.put('temp', String.valueOf(current.get('temp_c')));
            response.put('condition', (String) condition.get('text'));

            return response;

        } else {
            throw new AuraHandledException('Error fetching data');
        }
    }
}