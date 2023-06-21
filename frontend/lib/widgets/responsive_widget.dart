import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final List<Widget> children;

  const ResponsiveWidget({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 800;

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: isSmallScreen ? _buildColumn() : _buildRow(),
    );
  }

  Widget _buildColumn() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  Widget _buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }
}
