
import 'package:flutter/material.dart';

import 'index.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 1212),
      child: Row(
        children: [
          
            LabelText(text: "skip", fontSize: AppFontSize.large, ),
            SizedBox(width: 10,),
            Icon(Icons.arrow_forward, ),
    
        
        ],
      ),
    
    );
  }
}
