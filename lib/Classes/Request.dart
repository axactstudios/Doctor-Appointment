class Request {
  String reqID,
      appDate,
      bookDate,
      bookTime,
      dogAge,
      dogBreed,
      dogName,
      from,
      ownerEmail,
      ownerName,
      ownerPhone,
      to;

  Request(
      {this.appDate,
      this.to,
      this.ownerEmail,
      this.ownerPhone,
      this.ownerName,
      this.dogBreed,
      this.dogName,
      this.from,
      this.dogAge,
      this.bookDate,
      this.bookTime,
      this.reqID});
}
