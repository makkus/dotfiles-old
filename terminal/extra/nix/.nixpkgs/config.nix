{
    allowUnfree = true;

    chromium = {
     enablePepperFlash = true; # Chromium's non-NSAPI alternative to Adobe Flash
     enablePepperPDF = true;
    };

    packageOverrides = pkgs: rec {
     jdk = pkgs.oraclejdk8psu;
      };


}
