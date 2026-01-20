import 'package:flutter/material.dart';

class CustomKeypad extends StatelessWidget {
  final Function(String) onKeyPressed;
  final VoidCallback onDelete;
  final VoidCallback onClear;

  const CustomKeypad({
    super.key,
    required this.onKeyPressed,
    required this.onDelete,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRow(['1', '2', '3'], ['', 'ABC', 'DEF']),
        const SizedBox(height: 14), // Add gap between rows
        _buildRow(['4', '5', '6'], ['GHI', 'JKL', 'MNO']),
        const SizedBox(height: 14),
        _buildRow(['7', '8', '9'], ['PQRS', 'TUV', 'WXYZ']),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 106), // Spacer to match key width
            _buildKey('0', ''),
            _buildIconKey(Icons.backspace_outlined, onDelete),
          ],
        ),
      ],
    );
  }

  Widget _buildRow(List<String> numbers, List<String> letters) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        3,
        (index) => _buildKey(numbers[index], letters[index]),
      ),
    );
  }

  Widget _buildKey(String number, String letters) {
    return GestureDetector(
      onTap: () => onKeyPressed(number),
      child: Container(
        width: 106,
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              spreadRadius: 0,
              blurRadius: 0,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number,
              style: const TextStyle(
                fontSize: 20, // Reduced from 28 to fit 46px
                fontWeight: FontWeight.w500,
                height: 1.0,
                color: Colors.black,
              ),
            ),
            if (letters.isNotEmpty)
              Text(
                letters,
                style: const TextStyle(
                  fontSize: 7, // Reduced from 10 to fit
                  color: Colors.black, // Darker for better visibility on white
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconKey(IconData icon, VoidCallback onTap) {
    return SizedBox(
      width: 106,
      height: 46,
      child: InkWell(
        onTap: onTap,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.6),
        ),
        child: Center(child: Icon(icon, size: 24)),
      ),
    );
  }
}
