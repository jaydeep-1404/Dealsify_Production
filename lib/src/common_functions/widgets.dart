
import 'package:flutter/material.dart';

BorderRadius radius_all(dynamic value) {
  if (value == null) {
    return BorderRadius.circular(0.0);
  } else if (value is int) {
    return BorderRadius.all(Radius.circular(value.toDouble()));
  } else {
    return BorderRadius.circular(value);
  }
}

BorderRadius radius_only({topLeft,bottomLeft,bottomRight,topRight}){return BorderRadius.only(
  topLeft: topLeft == null ? const Radius.circular(0.0) : topLeft is int ? Radius.circular(topLeft.toDouble()) : Radius.circular(topLeft),
  bottomLeft: bottomLeft == null ? const Radius.circular(0.0) : bottomLeft is int ? Radius.circular(bottomLeft.toDouble()) : Radius.circular(bottomLeft),
  bottomRight: bottomRight == null ? const Radius.circular(0.0) : bottomRight is int ? Radius.circular(bottomRight.toDouble()) : Radius.circular(bottomRight),
  topRight: topRight == null ? const Radius.circular(0.0) : topRight is int ? Radius.circular(topRight.toDouble()) : Radius.circular(topRight),
);}

EdgeInsets all(value) {
  if (value == null) {
    return const EdgeInsets.all(0.0);
  } else if (value is int)  {
    return EdgeInsets.all(value.toDouble());
  } else {
    return EdgeInsets.all(value);
  }
}

EdgeInsets symmetric({h,v}) {
  return EdgeInsets.symmetric(
    horizontal: h == null ? 0.0 : h is int ? h.toDouble() : h,
    vertical: v == null ? 0.0 : v is int ? v.toDouble() : v,
  );
}

EdgeInsets only({t,b,l,r}) {
  return EdgeInsets.only(
    top: t == null ? 0.0 : t is int ? t.toDouble() : t,
    bottom: b == null ? 0.0 : b is int ? b.toDouble() : b,
    left: l == null ? 0.0 : l is int ? l.toDouble() : l,
    right: r == null ? 0.0 : r is int ? r.toDouble() : r,
  );
}
