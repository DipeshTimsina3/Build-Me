var ipAddress = '192.168.1.134';

var getImageUrl = (imageUrl) {
  return 'http://$ipAddress/ecom2_api/$imageUrl';
};

var formatDate = (DateTime? date) {
  if (date == null) return '-';
  return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}';
};
