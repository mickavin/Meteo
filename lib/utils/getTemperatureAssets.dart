Map<String, dynamic> getTemperatureAssets(String icon){
  if(icon == "11j"){
    return {
      "icon": "assets/icons/004-tempete.png",
      "backgroundColor": 0xFF74b9ff,
      "color": 0xFF0984e3
    };
  }else if(icon == "09d"){
    return {
      "icon": "assets/icons/002-pluvieux.png",
      "backgroundColor": 0xFF74b9ff,
      "color": 0xFF0984e3
    };
  }else if(icon == "10d"){
    return {
      "icon": "assets/icons/storm.png",
      "backgroundColor": 0xFFFFEAA7,
      "color": 0xFFfdcb6e
    };
  }else if(icon == "13d"){
    return {
      "icon": "assets/icons/009-flocon-de-neige.png",
      "backgroundColor": 0xFF74b9ff,
      "color": 0xFF0984e3
    };
  }else if(icon == "50d"){
    return {
      "icon": "assets/icons/005-nuageux.png",
      "backgroundColor": 0xFF74b9ff,
      "color": 0xFF0984e3
    };
  }else if(icon == "01d" || icon == "01n"){
    return {
      "icon": "assets/icons/003-soleil.png",
      "backgroundColor": 0xFFFFEAA7,
      "color": 0xFFfdcb6e
    };
  }else if(icon == "02d" || icon == "02n"){
    return {
      "icon": "assets/icons/001-nuage.png",
      "backgroundColor": 0xFFFFEAA7,
      "color": 0xFFfdcb6e
    };
  }else if(icon == "03d" || icon == "03n"){
    return {
      "icon": "assets/icons/005-nuageux.png",
      "backgroundColor": 0xFF74b9ff,
      "color": 0xFF0984e3
    };
  }else {
    return {
      "icon": "assets/icons/003-soleil.png",
      "backgroundColor": 0xFFFFEAA7,
      "color": 0xFFfdcb6e
    };
  }
}