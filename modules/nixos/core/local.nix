{ config, ... }: {
  # Time zone and Locale
  time.timeZone = config.myNixosSettings.timeZone;
  i18n.defaultLocale = config.myNixosSettings.defaultLocale;
  console.keyMap = config.myNixosSettings.keyboardLayout;
}
