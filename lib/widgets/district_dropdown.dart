import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/districts.dart';
import '../providers/driver_provider.dart';

class DistrictDropdown extends StatelessWidget {
  const DistrictDropdown({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DriverProvider>();
    return DropdownButton<District>(
      value: provider.selectedDistrict,
      isExpanded: true,
      items: bdDistricts.map((d) => DropdownMenuItem(value: d, child: Text("${d.nameBn} - ${d.nameEn}"))).toList(),
      onChanged: (v) { if(v!=null) provider.setDistrict(v); },
    );
  }
}