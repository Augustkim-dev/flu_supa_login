part of 'index.dart';

class JunElevatedButton extends StatelessWidget {
  String title;
  VoidCallback onPressed;
  Color? fontColor;
  Color? backgroundColor;
  String? svgPath;
  int? widthImg;
  int? heightImg;

  JunElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.fontColor = Colors.white,
    this.backgroundColor = Colors.black,
    this.svgPath = null,
    this.widthImg,
    this.heightImg,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Container(
            child: svgPath != null
                ? SvgPicture.asset(
                    svgPath!,
                    width: widthImg?.toDouble(),
                    height: heightImg?.toDouble(),
                  )
                : Container(),
          ),
          Expanded(
            child: Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: fontColor)),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            4,
          ),
        ),
      ),
    );
  }
}
