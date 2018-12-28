class ConstellationDetail {
  String showapiResError;
  String showapiResId;
  int showapiResCode;
  ShowapiResBody showapiResBody;

  ConstellationDetail(
      {this.showapiResError,
      this.showapiResId,
      this.showapiResCode,
      this.showapiResBody});

  ConstellationDetail.fromJson(Map<String, dynamic> json) {
    showapiResError = json['showapi_res_error'];
    showapiResId = json['showapi_res_id'];
    showapiResCode = json['showapi_res_code'];
    showapiResBody = json['showapi_res_body'] != null
        ? new ShowapiResBody.fromJson(json['showapi_res_body'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['showapi_res_error'] = this.showapiResError;
    data['showapi_res_id'] = this.showapiResId;
    data['showapi_res_code'] = this.showapiResCode;
    if (this.showapiResBody != null) {
      data['showapi_res_body'] = this.showapiResBody.toJson();
    }
    return data;
  }
}

class ShowapiResBody {
  Day day;
  String star;
  int retCode;

  ShowapiResBody({this.day, this.star, this.retCode});

  ShowapiResBody.fromJson(Map<String, dynamic> json) {
    day = json['day'] != null ? new Day.fromJson(json['day']) : null;
    star = json['star'];
    retCode = json['ret_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.day != null) {
      data['day'] = this.day.toJson();
    }
    data['star'] = this.star;
    data['ret_code'] = this.retCode;
    return data;
  }
}

class Day {
  int summaryStar;
  int loveStar;
  int moneyStar;
  int workStar;
  String luckyTime;
  String luckyDirection;
  String luckyNum;
  String grxz;
  String luckyColor;
  String dayNotice;
  String generalTxt;
  String loveTxt;
  String workTxt;
  String moneyTxt;
  String time;

  Day(
      {this.summaryStar,
      this.loveStar,
      this.moneyStar,
      this.workStar,
      this.luckyTime,
      this.luckyDirection,
      this.luckyNum,
      this.grxz,
      this.luckyColor,
      this.dayNotice,
      this.generalTxt,
      this.loveTxt,
      this.workTxt,
      this.moneyTxt,
      this.time});

  Day.fromJson(Map<String, dynamic> json) {
    summaryStar = json['summary_star'];
    loveStar = json['love_star'];
    moneyStar = json['money_star'];
    workStar = json['work_star'];
    luckyTime = json['lucky_time'];
    luckyDirection = json['lucky_direction'];
    luckyNum = json['lucky_num'];
    grxz = json['grxz'];
    luckyColor = json['lucky_color'];
    dayNotice = json['day_notice'];
    generalTxt = json['general_txt'];
    loveTxt = json['love_txt'];
    workTxt = json['work_txt'];
    moneyTxt = json['money_txt'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['summary_star'] = this.summaryStar;
    data['love_star'] = this.loveStar;
    data['money_star'] = this.moneyStar;
    data['work_star'] = this.workStar;
    data['lucky_time'] = this.luckyTime;
    data['lucky_direction'] = this.luckyDirection;
    data['lucky_num'] = this.luckyNum;
    data['grxz'] = this.grxz;
    data['lucky_color'] = this.luckyColor;
    data['day_notice'] = this.dayNotice;
    data['general_txt'] = this.generalTxt;
    data['love_txt'] = this.loveTxt;
    data['work_txt'] = this.workTxt;
    data['money_txt'] = this.moneyTxt;
    data['time'] = this.time;
    return data;
  }
}
