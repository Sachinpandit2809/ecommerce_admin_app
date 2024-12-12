discountPrice(oldPrice, newPrice) {
  if (oldPrice == 0) {
    return "0";
  } else {
    double discount = ((oldPrice - newPrice) / oldPrice) * 100;
    return discount;
  }
}
