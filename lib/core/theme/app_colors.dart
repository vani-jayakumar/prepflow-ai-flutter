import 'package:flutter/material.dart';

class AppColors {
  // ============================================
  // LIGHT MODE - Apple-Inspired Premium Palette
  // ============================================

  // Backgrounds - Layered surface system
  static const lightBgPrimary = Color(0xFFF5F5F7);      // Main background (Apple gray)
  static const lightBgSecondary = Color(0xFFFFFFFF);    // Cards, elevated surfaces
  static const lightBgTertiary = Color(0xFFFAFAFA);     // Grouped content background

  // Surfaces for glassmorphism
  static const lightSurfaceLow = Color(0xFFFFFFFF);     // Base surface
  static const lightSurfaceMedium = Color(0xFFF8F8FA);  // Elevated surface
  static const lightSurfaceHigh = Color(0xFFFFFFFF);    // Highest elevation

  // Separators & Borders
  static const lightSeparator = Color(0xFFC6C6C8);       // Hairline separators
  static const lightSeparatorOpaque = Color(0x49C6C6C8); // 29% opacity separator
  static const lightBorder = Color(0x1F000000);          // 12% black for borders

  // Glass effect colors
  static const lightGlass = Color(0xCCFFFFFF);          // 80% white glass
  static const lightGlassBorder = Color(0x33FFFFFF);    // 20% white border

  // ============================================
  // DARK MODE - Premium Dark Palette
  // ============================================

  // Backgrounds - Layered dark system
  static const darkBgPrimary = Color(0xFF020617);       // Deepest Slate (OLED friendly)
  static const darkBgSecondary = Color(0xFF0F172A);     // Elevated surfaces (Gunmetal)
  static const darkBgTertiary = Color(0xFF1E293B);      // Highest elevation (Slate 800)

  // Surfaces for glassmorphism
  static const darkSurfaceLow = Color(0xFF1E293B);      // Base surface
  static const darkSurfaceMedium = Color(0xFF334155);   // Elevated surface
  static const darkSurfaceHigh = Color(0xFF475569);     // Highest elevation

  // Separators & Borders
  static const darkSeparator = Color(0xFF334155);       // Hairline separators
  static const darkSeparatorOpaque = Color(0x49334155);  // 29% opacity separator
  static const darkBorder = Color(0x3394A3B8);          // 20% Slate 400 for borders

  // Glass effect colors
  static const darkGlass = Color(0xBF0F172A);           // 75% dark glass
  static const darkGlassBorder = Color(0x1A94A3B8);     // 10% Slate 400 border

  // ============================================
  // GRADIENTS - Unique Premium Accents
  // ============================================

  // Primary Gradients (Veridian -> Seafoam flow)
  static const lightGradPrimary = [Color(0xFF059669), Color(0xFF10B981)];
  static const darkGradPrimary = [Color(0xFF059669), Color(0xFF2DD4BF)];

  // Secondary Gradients (Sky -> Indigo flow - unique but familiar)
  static const lightGradSecondary = [Color(0xFF0EA5E9), Color(0xFF059669)];
  static const darkGradSecondary = [Color(0xFF38BDF8), Color(0xFF818CF8)];

  // Accent Gradients (Amber -> Rose)
  static const lightGradAccent = [Color(0xFFF59E0B), Color(0xFFF43F5E)];
  static const darkGradAccent = [Color(0xFFFBBF24), Color(0xFFFB7185)];

  // Premium multi-stop gradients (for shimmer effects)
  static const shimmerLight = [
    Color(0x00FFFFFF),
    Color(0x33FFFFFF),
    Color(0x00FFFFFF),
  ];
  static const shimmerDark = [
    Color(0x00FFFFFF),
    Color(0x1AFFFFFF),
    Color(0x00FFFFFF),
  ];

  // ============================================
  // TEXT COLORS
  // ============================================

  // Light Mode Text
  static const lightTextPrimary = Color(0xFF1D1D1F);     // Apple's primary text
  static const lightTextSecondary = Color(0xFF86868B);   // Secondary gray
  static const lightTextTertiary = Color(0xFFAEAEB2);    // Tertiary/placeholder
  static const lightTextDisabled = Color(0xFFC7C7CC);    // Disabled state

  // Dark Mode Text
  static const darkTextPrimary = Color(0xFFFFFFFF);       // Pure white
  static const darkTextSecondary = Color(0xFF98989D);     // Secondary gray
  static const darkTextTertiary = Color(0xFF636366);      // Tertiary/placeholder
  static const darkTextDisabled = Color(0xFF48484A);      // Disabled state

  // ============================================
  // SYSTEM SEMANTIC COLORS
  // ============================================

  // Primary Accent (Veridian - Premium & Unique)
  static const accentPrimary = Color(0xFF059669);        // Deep Veridian
  static const accentSecondary = Color(0xFF10B981);      // Seafoam Green
  static const accentTertiary = Color(0xFF0EA5E9);       // Sky Blue

  // Status Colors - Apple system colors
  static const success = Color(0xFF10B981);              // Seafoam green
  static const successLight = Color(0x1A10B981);         // 10% success
  static const warning = Color(0xFFF59E0B);              // Amber
  static const warningLight = Color(0x1AF59E0B);         // 10% warning
  static const danger = Color(0xFFF43F5E);               // Rose red
  static const dangerLight = Color(0x1AF43F5E);          // 10% danger
  static const info = Color(0xFF0EA5E9);                 // Sky blue
  static const infoLight = Color(0x1A0EA5E9);            // 10% info

  // ============================================
  // ELEVATION SHADOWS
  // ============================================

  // Shadow colors for depth (apply with blur)
  static const shadowLight = Color(0x0D000000);          // 5% black
  static const shadowMedium = Color(0x1A000000);         // 10% black
  static const shadowDark = Color(0x29000000);          // 16% black
  static const shadowAccent = Color(0x1A059669);         // 10% Veridian (for glow)

  // ============================================
  // HELPER METHODS
  // ============================================

  // Get glass color based on brightness
  static Color glassColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkGlass
        : lightGlass;
  }

  // Get border color based on brightness
  static Color borderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBorder
        : lightBorder;
  }

  // Get separator color based on brightness
  static Color separatorColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSeparator
        : lightSeparator;
  }
}
