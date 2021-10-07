const imagePath = "assets/images";

const imageLogo = "app_logo.jpeg";
const imageLogoStaging = "app_logo_staging.jpeg";

extension ImagePath on String {
    String get source => "$imagePath/$this";
}