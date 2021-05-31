import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

final mainHeaderTitle = TextStyle(
    fontSize: 24,
    height: (36 / 24),
    color: ANColor.white,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.poppins().fontFamily);

final generalPageHeaderTitle = TextStyle(
    fontSize: 18,
    height: (27 / 18),
    color: ANColor.white,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.poppins().fontFamily);

final homeNumberStyle = TextStyle(
    fontSize: 28,
    height: (42 / 28),
    color: ANColor.textPrimary,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.poppins().fontFamily);

final headerTitle = TextStyle(
    fontSize: 18,
    height: (27 / 18),
    color: ANColor.white,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.poppins().fontFamily);

final tabHeader = TextStyle(
    fontSize: 20,
    height: (30 / 20),
    color: ANColor.textPrimary,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.poppins().fontFamily);

final header1 = TextStyle(
    fontSize: 32,
    height: (48 / 32),
    color: ANColor.textPrimary,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.poppins().fontFamily);

final header2 = TextStyle(
    fontSize: 28,
    height: (42 / 28),
    color: ANColor.textPrimary,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.poppins().fontFamily);

final header3 = TextStyle(
    fontSize: 18,
    height: (27 / 18),
    color: ANColor.textPrimary,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.poppins().fontFamily);

final header4 = TextStyle(
    fontSize: 16,
    height: (24 / 16),
    color: ANColor.textPrimary,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.poppins().fontFamily);
final header4sec = header4.copyWith(color: ANColor.white);

final header5 = TextStyle(
    fontSize: 14,
    height: (21 / 14),
    color: ANColor.textPrimary,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.poppins().fontFamily);

final header5sec = header5.copyWith(color: ANColor.white);
final header5ter = header5.copyWith(color: ANColor().textTertiary);

final header6 = TextStyle(
    fontSize: 12,
    height: (18 / 12),
    color: ANColor.textPrimary,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.poppins().fontFamily);

final header6sec = header6.copyWith(color: ANColor().textSecondary);
final header6ter = header6.copyWith(color: ANColor().textTertiary);
final header6pri = header6.copyWith(color: ANColor.primary);

final header7 = TextStyle(
    fontSize: 10,
    height: (15 / 10),
    color: ANColor.textPrimary,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.poppins().fontFamily);

final header7sec = header6.copyWith(color: ANColor().textSecondary);
final header7ter = header6.copyWith(color: ANColor().textTertiary);

final radioLabelStyle = header4.copyWith(fontWeight: FontWeight.w500);
final dateStyle = header6ter.copyWith(fontWeight: FontWeight.w400);
final formFieldLabel = header5;
