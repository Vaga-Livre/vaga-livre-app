import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff006879),
      surfaceTint: Color(0xff006879),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffabedff),
      onPrimaryContainer: Color(0xff001f26),
      secondary: Color(0xff4b6269),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcee7ee),
      onSecondaryContainer: Color(0xff061f24),
      tertiary: Color(0xff565d7e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffdde1ff),
      onTertiaryContainer: Color(0xff131a37),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff5fafc),
      onBackground: Color(0xff171c1e),
      surface: Color(0xfff5fafc),
      onSurface: Color(0xff171c1e),
      surfaceVariant: Color(0xffdbe4e7),
      onSurfaceVariant: Color(0xff3f484b),
      outline: Color(0xff70797b),
      outlineVariant: Color(0xffbfc8cb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3133),
      inverseOnSurface: Color(0xffecf2f4),
      inversePrimary: Color(0xff84d2e6),
      primaryFixed: Color(0xffabedff),
      onPrimaryFixed: Color(0xff001f26),
      primaryFixedDim: Color(0xff84d2e6),
      onPrimaryFixedVariant: Color(0xff004e5c),
      secondaryFixed: Color(0xffcee7ee),
      onSecondaryFixed: Color(0xff061f24),
      secondaryFixedDim: Color(0xffb2cbd2),
      onSecondaryFixedVariant: Color(0xff334a51),
      tertiaryFixed: Color(0xffdde1ff),
      onTertiaryFixed: Color(0xff131a37),
      tertiaryFixedDim: Color(0xffbec4eb),
      onTertiaryFixedVariant: Color(0xff3e4565),
      surfaceDim: Color(0xffd5dbdd),
      surfaceBright: Color(0xfff5fafc),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xffeff4f6),
      surfaceContainer: Color(0xffe9eff1),
      surfaceContainerHigh: Color(0xffe4e9eb),
      surfaceContainerHighest: Color(0xffdee3e5),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff004a57),
      surfaceTint: Color(0xff006879),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff297f91),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2f464d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff61787f),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff3b4161),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6c7395),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff5fafc),
      onBackground: Color(0xff171c1e),
      surface: Color(0xfff5fafc),
      onSurface: Color(0xff171c1e),
      surfaceVariant: Color(0xffdbe4e7),
      onSurfaceVariant: Color(0xff3b4447),
      outline: Color(0xff586163),
      outlineVariant: Color(0xff737c7f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3133),
      inverseOnSurface: Color(0xffecf2f4),
      inversePrimary: Color(0xff84d2e6),
      primaryFixed: Color(0xff297f91),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff006576),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff61787f),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff486066),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6c7395),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff545a7b),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbdd),
      surfaceBright: Color(0xfff5fafc),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff4f6),
      surfaceContainer: Color(0xffe9eff1),
      surfaceContainerHigh: Color(0xffe4e9eb),
      surfaceContainerHighest: Color(0xffdee3e5),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff00262e),
      surfaceTint: Color(0xff006879),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004a57),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff0d252b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2f464d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff1a203e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff3b4161),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff5fafc),
      onBackground: Color(0xff171c1e),
      surface: Color(0xfff5fafc),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffdbe4e7),
      onSurfaceVariant: Color(0xff1d2528),
      outline: Color(0xff3b4447),
      outlineVariant: Color(0xff3b4447),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3133),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffcaf3ff),
      primaryFixed: Color(0xff004a57),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00323b),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff2f464d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff193036),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff3b4161),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff242b49),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbdd),
      surfaceBright: Color(0xfff5fafc),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff4f6),
      surfaceContainer: Color(0xffe9eff1),
      surfaceContainerHigh: Color(0xffe4e9eb),
      surfaceContainerHighest: Color(0xffdee3e5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff84d2e6),
      surfaceTint: Color(0xff84d2e6),
      onPrimary: Color(0xff003640),
      primaryContainer: Color(0xff004e5c),
      onPrimaryContainer: Color(0xffabedff),
      secondary: Color(0xffb2cbd2),
      onSecondary: Color(0xff1d343a),
      secondaryContainer: Color(0xff334a51),
      onSecondaryContainer: Color(0xffcee7ee),
      tertiary: Color(0xffbec4eb),
      onTertiary: Color(0xff282f4d),
      tertiaryContainer: Color(0xff3e4565),
      onTertiaryContainer: Color(0xffdde1ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff0f1416),
      onBackground: Color(0xffdee3e5),
      surface: Color(0xff0f1416),
      onSurface: Color(0xffdee3e5),
      surfaceVariant: Color(0xff3f484b),
      onSurfaceVariant: Color(0xffbfc8cb),
      outline: Color(0xff899295),
      outlineVariant: Color(0xff3f484b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inverseOnSurface: Color(0xff2c3133),
      inversePrimary: Color(0xff006879),
      primaryFixed: Color(0xffabedff),
      onPrimaryFixed: Color(0xff001f26),
      primaryFixedDim: Color(0xff84d2e6),
      onPrimaryFixedVariant: Color(0xff004e5c),
      secondaryFixed: Color(0xffcee7ee),
      onSecondaryFixed: Color(0xff061f24),
      secondaryFixedDim: Color(0xffb2cbd2),
      onSecondaryFixedVariant: Color(0xff334a51),
      tertiaryFixed: Color(0xffdde1ff),
      onTertiaryFixed: Color(0xff131a37),
      tertiaryFixedDim: Color(0xffbec4eb),
      onTertiaryFixedVariant: Color(0xff3e4565),
      surfaceDim: Color(0xff0f1416),
      surfaceBright: Color(0xff343a3c),
      surfaceContainerLowest: Color(0xff090f11),
      surfaceContainerLow: Color(0xff171c1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2d),
      surfaceContainerHighest: Color(0xff303638),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff88d6eb),
      surfaceTint: Color(0xff84d2e6),
      onPrimary: Color(0xff00191f),
      primaryContainer: Color(0xff4b9bae),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb6cfd6),
      onSecondary: Color(0xff01191f),
      secondaryContainer: Color(0xff7d959c),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffc3c9ef),
      onTertiary: Color(0xff0d1431),
      tertiaryContainer: Color(0xff898fb3),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff0f1416),
      onBackground: Color(0xffdee3e5),
      surface: Color(0xff0f1416),
      onSurface: Color(0xfff6fcfe),
      surfaceVariant: Color(0xff3f484b),
      onSurfaceVariant: Color(0xffc3cccf),
      outline: Color(0xff9ba4a7),
      outlineVariant: Color(0xff7c8588),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inverseOnSurface: Color(0xff252b2d),
      inversePrimary: Color(0xff004f5d),
      primaryFixed: Color(0xffabedff),
      onPrimaryFixed: Color(0xff001419),
      primaryFixedDim: Color(0xff84d2e6),
      onPrimaryFixedVariant: Color(0xff003c47),
      secondaryFixed: Color(0xffcee7ee),
      onSecondaryFixed: Color(0xff001419),
      secondaryFixedDim: Color(0xffb2cbd2),
      onSecondaryFixedVariant: Color(0xff233a40),
      tertiaryFixed: Color(0xffdde1ff),
      onTertiaryFixed: Color(0xff080f2c),
      tertiaryFixedDim: Color(0xffbec4eb),
      onTertiaryFixedVariant: Color(0xff2e3453),
      surfaceDim: Color(0xff0f1416),
      surfaceBright: Color(0xff343a3c),
      surfaceContainerLowest: Color(0xff090f11),
      surfaceContainerLow: Color(0xff171c1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2d),
      surfaceContainerHighest: Color(0xff303638),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff4fcff),
      surfaceTint: Color(0xff84d2e6),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff88d6eb),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff4fcff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb6cfd6),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffcfaff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffc3c9ef),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff0f1416),
      onBackground: Color(0xffdee3e5),
      surface: Color(0xff0f1416),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff3f484b),
      onSurfaceVariant: Color(0xfff4fcff),
      outline: Color(0xffc3cccf),
      outlineVariant: Color(0xffc3cccf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff002f38),
      primaryFixed: Color(0xffb9f0ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff88d6eb),
      onPrimaryFixedVariant: Color(0xff00191f),
      secondaryFixed: Color(0xffd2ebf3),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb6cfd6),
      onSecondaryFixedVariant: Color(0xff01191f),
      tertiaryFixed: Color(0xffe3e5ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc3c9ef),
      onTertiaryFixedVariant: Color(0xff0d1431),
      surfaceDim: Color(0xff0f1416),
      surfaceBright: Color(0xff343a3c),
      surfaceContainerLowest: Color(0xff090f11),
      surfaceContainerLow: Color(0xff171c1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2d),
      surfaceContainerHighest: Color(0xff303638),
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

  List<ExtendedColor> get extendedColors => [];
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
