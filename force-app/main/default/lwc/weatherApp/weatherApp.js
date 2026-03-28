// import { LightningElement, track } from 'lwc';
// import getWeather from '@salesforce/apex/WeatherService.getWeather';

// export default class WeatherApp extends LightningElement {

//     @track city;
//     @track result;

//     handleChange(event) {
//         this.city = event.target.value;
//     }

//     getWeather() {

//         if(!this.city){
//             this.result = 'Please enter a city';
//             return;
//         }

//         getWeather({ city: this.city })
//             .then(data => {
//                 this.result = data;
//             })
//             .catch(error => {
//                 this.result = 'Error fetching data';
//             });
//     }
// }
import { LightningElement, track } from 'lwc';
import getWeather from '@salesforce/apex/WeatherService.getWeather';

export default class WeatherApp extends LightningElement {

    city;
    @track weatherData;

    handleChange(event) {
        this.city = event.target.value;
    }

    getWeather() {
         console.log('Button clicked'); 
        getWeather({ city: this.city })
            .then(data => {
                 console.log('DATA:', data);
                this.weatherData = data;
            })
            .catch(error => {
                console.error('ERROR:', error);
            });
    }
}