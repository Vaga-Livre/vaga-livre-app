import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4278216825),
      surfaceTint: Color(4278216825),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4289457663),
      onPrimaryContainer: Color(4278198054),
      secondary: Color(4283130473),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4291749870),
      onSecondaryContainer: Color(4278591268),
      tertiary: Color(4283850110),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4292731391),
      onTertiaryContainer: Color(4279441975),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      background: Color(4294310652),
      onBackground: Color(4279704606),
      surface: Color(4294310652),
      onSurface: Color(4279704606),
      surfaceVariant: Color(4292601063),
      onSurfaceVariant: Color(4282337355),
      outline: Color(4285561211),
      outlineVariant: Color(4290758859),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281086259),
      inverseOnSurface: Color(4293718772),
      inversePrimary: Color(4286894822),
      primaryFixed: Color(4289457663),
      onPrimaryFixed: Color(4278198054),
      primaryFixedDim: Color(4286894822),
      onPrimaryFixedVariant: Color(4278210140),
      secondaryFixed: Color(4291749870),
      onSecondaryFixed: Color(4278591268),
      secondaryFixedDim: Color(4289907666),
      onSecondaryFixedVariant: Color(4281551441),
      tertiaryFixed: Color(4292731391),
      onTertiaryFixed: Color(4279441975),
      tertiaryFixedDim: Color(4290692331),
      onTertiaryFixedVariant: Color(4282271077),
      surfaceDim: Color(4292205533),
      surfaceBright: Color(4294310652),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293915894),
      surfaceContainer: Color(4293521393),
      surfaceContainerHigh: Color(4293192171),
      surfaceContainerHighest: Color(4292797413),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4278209111),
      surfaceTint: Color(4278216825),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4280909713),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281288269),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4284577919),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4282073441),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4285297557),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      background: Color(4294310652),
      onBackground: Color(4279704606),
      surface: Color(4294310652),
      onSurface: Color(4279704606),
      surfaceVariant: Color(4292601063),
      onSurfaceVariant: Color(4282074183),
      outline: Color(4283982179),
      outlineVariant: Color(4285758591),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281086259),
      inverseOnSurface: Color(4293718772),
      inversePrimary: Color(4286894822),
      primaryFixed: Color(4280909713),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278216054),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4284577919),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4282933350),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4285297557),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4283718267),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292205533),
      surfaceBright: Color(4294310652),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293915894),
      surfaceContainer: Color(4293521393),
      surfaceContainerHigh: Color(4293192171),
      surfaceContainerHighest: Color(4292797413),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4278199854),
      surfaceTint: Color(4278216825),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4278209111),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4279051563),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4281288269),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4279902270),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4282073441),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      background: Color(4294310652),
      onBackground: Color(4279704606),
      surface: Color(4294310652),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4292601063),
      onSurfaceVariant: Color(4280100136),
      outline: Color(4282074183),
      outlineVariant: Color(4282074183),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281086259),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4291490815),
      primaryFixed: Color(4278209111),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278202939),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4281288269),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4279840822),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4282073441),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4280560457),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292205533),
      surfaceBright: Color(4294310652),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293915894),
      surfaceContainer: Color(4293521393),
      surfaceContainerHigh: Color(4293192171),
      surfaceContainerHighest: Color(4292797413),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4286894822),
      surfaceTint: Color(4286894822),
      onPrimary: Color(4278203968),
      primaryContainer: Color(4278210140),
      onPrimaryContainer: Color(4289457663),
      secondary: Color(4289907666),
      onSecondary: Color(4280103994),
      secondaryContainer: Color(4281551441),
      onSecondaryContainer: Color(4291749870),
      tertiary: Color(4290692331),
      onTertiary: Color(4280823629),
      tertiaryContainer: Color(4282271077),
      onTertiaryContainer: Color(4292731391),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      background: Color(4279178262),
      onBackground: Color(4292797413),
      surface: Color(4279178262),
      onSurface: Color(4292797413),
      surfaceVariant: Color(4282337355),
      onSurfaceVariant: Color(4290758859),
      outline: Color(4287206037),
      outlineVariant: Color(4282337355),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292797413),
      inverseOnSurface: Color(4281086259),
      inversePrimary: Color(4278216825),
      primaryFixed: Color(4289457663),
      onPrimaryFixed: Color(4278198054),
      primaryFixedDim: Color(4286894822),
      onPrimaryFixedVariant: Color(4278210140),
      secondaryFixed: Color(4291749870),
      onSecondaryFixed: Color(4278591268),
      secondaryFixedDim: Color(4289907666),
      onSecondaryFixedVariant: Color(4281551441),
      tertiaryFixed: Color(4292731391),
      onTertiaryFixed: Color(4279441975),
      tertiaryFixedDim: Color(4290692331),
      onTertiaryFixedVariant: Color(4282271077),
      surfaceDim: Color(4279178262),
      surfaceBright: Color(4281612860),
      surfaceContainerLowest: Color(4278783761),
      surfaceContainerLow: Color(4279704606),
      surfaceContainer: Color(4279968034),
      surfaceContainerHigh: Color(4280625965),
      surfaceContainerHighest: Color(4281349688),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4287157995),
      surfaceTint: Color(4286894822),
      onPrimary: Color(4278196511),
      primaryContainer: Color(4283145134),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290170838),
      onSecondary: Color(4278262047),
      secondaryContainer: Color(4286420380),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4291021295),
      onTertiary: Color(4279047217),
      tertiaryContainer: Color(4287205299),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      background: Color(4279178262),
      onBackground: Color(4292797413),
      surface: Color(4279178262),
      onSurface: Color(4294376702),
      surfaceVariant: Color(4282337355),
      onSurfaceVariant: Color(4291022031),
      outline: Color(4288390311),
      outlineVariant: Color(4286350728),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292797413),
      inverseOnSurface: Color(4280625965),
      inversePrimary: Color(4278210397),
      primaryFixed: Color(4289457663),
      onPrimaryFixed: Color(4278195225),
      primaryFixedDim: Color(4286894822),
      onPrimaryFixedVariant: Color(4278205511),
      secondaryFixed: Color(4291749870),
      onSecondaryFixed: Color(4278195225),
      secondaryFixedDim: Color(4289907666),
      onSecondaryFixedVariant: Color(4280498752),
      tertiaryFixed: Color(4292731391),
      onTertiaryFixed: Color(4278718252),
      tertiaryFixedDim: Color(4290692331),
      onTertiaryFixedVariant: Color(4281218131),
      surfaceDim: Color(4279178262),
      surfaceBright: Color(4281612860),
      surfaceContainerLowest: Color(4278783761),
      surfaceContainerLow: Color(4279704606),
      surfaceContainer: Color(4279968034),
      surfaceContainerHigh: Color(4280625965),
      surfaceContainerHighest: Color(4281349688),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294245631),
      surfaceTint: Color(4286894822),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4287157995),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294245631),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4290170838),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294769407),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4291021295),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      background: Color(4279178262),
      onBackground: Color(4292797413),
      surface: Color(4279178262),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4282337355),
      onSurfaceVariant: Color(4294245631),
      outline: Color(4291022031),
      outlineVariant: Color(4291022031),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292797413),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4278202168),
      primaryFixed: Color(4290375935),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4287157995),
      onPrimaryFixedVariant: Color(4278196511),
      secondaryFixed: Color(4292013043),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4290170838),
      onSecondaryFixedVariant: Color(4278262047),
      tertiaryFixed: Color(4293125631),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4291021295),
      onTertiaryFixedVariant: Color(4279047217),
      surfaceDim: Color(4279178262),
      surfaceBright: Color(4281612860),
      surfaceContainerLowest: Color(4278783761),
      surfaceContainerLow: Color(4279704606),
      surfaceContainer: Color(4279968034),
      surfaceContainerHigh: Color(4280625965),
      surfaceContainerHighest: Color(4281349688),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary, 
    required this.surfaceTint, 
    required this.onPrimary, 
    required this.primaryContainer, 
    required this.onPrimaryContainer, 
    required this.secondary, 
    required this.onSecondary, 
    required this.secondaryContainer, 
    required this.onSecondaryContainer, 
    required this.tertiary, 
    required this.onTertiary, 
    required this.tertiaryContainer, 
    required this.onTertiaryContainer, 
    required this.error, 
    required this.onError, 
    required this.errorContainer, 
    required this.onErrorContainer, 
    required this.background, 
    required this.onBackground, 
    required this.surface, 
    required this.onSurface, 
    required this.surfaceVariant, 
    required this.onSurfaceVariant, 
    required this.outline, 
    required this.outlineVariant, 
    required this.shadow, 
    required this.scrim, 
    required this.inverseSurface, 
    required this.inverseOnSurface, 
    required this.inversePrimary, 
    required this.primaryFixed, 
    required this.onPrimaryFixed, 
    required this.primaryFixedDim, 
    required this.onPrimaryFixedVariant, 
    required this.secondaryFixed, 
    required this.onSecondaryFixed, 
    required this.secondaryFixedDim, 
    required this.onSecondaryFixedVariant, 
    required this.tertiaryFixed, 
    required this.onTertiaryFixed, 
    required this.tertiaryFixedDim, 
    required this.onTertiaryFixedVariant, 
    required this.surfaceDim, 
    required this.surfaceBright, 
    required this.surfaceContainerLowest, 
    required this.surfaceContainerLow, 
    required this.surfaceContainer, 
    required this.surfaceContainerHigh, 
    required this.surfaceContainerHighest, 
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
            inversePrimary: inversePrimary,
surfaceDim: surfaceDim,
      surfaceBright: surfaceBright,
      surfaceContainerLowest: surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainer: surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
