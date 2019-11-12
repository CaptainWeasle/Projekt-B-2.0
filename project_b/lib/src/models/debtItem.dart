class DebtItem {
  int id;
  String name = "";
  double debt;
  String debtStartDate;
  String debtDeadlineDate;
  int priority;
  bool iOwe;
  bool isDone;

  DebtItem._();
  DebtItem({
    this.id,
    this.name,
    this.debt,
    this.debtStartDate,
    this.debtDeadlineDate,
    this.priority,
    this.iOwe,
    this.isDone,
  });

  String getName() => name;
  double getDebt() => debt;
  String getDebtStart() => debtStartDate;
  String getDebtDeadline() => debtDeadlineDate;
  int getPriority(){
    return priority;
  }

  String toString(){
    return "NAME: $name, DEBT: $debt, DO I OWE? $iOwe, DEBT START: $debtStartDate, DEBT DEADLINE: $debtDeadlineDate, PRIORITY: $priority";
  }

  
  factory DebtItem.initial(){
    return DebtItem._()
    ..name = ""
    ..debt = 0
    ..debtStartDate = DateTime.now().toString();
  }
  

  factory DebtItem.fromDatabaseJson(Map<String, dynamic> data) => DebtItem(
    //This will be used to convert JSON objects that
    //are coming from querying the database and converting
    //it into a Todo object
        id: data['id'],
        name: data['name'],
        debt: data['debt'],
        debtStartDate: data['debtStartDate'],
        debtDeadlineDate: data['debtDeadlineDate'],
        priority: data['priority'],
        iOwe: data['iOwe'] == 1 ? true : false,
        //Since sqlite doesn't have boolean type for true/false
        //we will 0 to denote that it is false
        //and 1 for true
        isDone: data['is_done'] == 1 ? true : false,
      );
  Map<String, dynamic> toDatabaseJson() => {
    //This will be used to convert Todo objects that
    //are to be stored into the datbase in a form of JSON
        "id": this.id,
        "name": this.name,
        "debt": this.debt,
        "debtStartDate": this.debtStartDate,
        "debtDeadlineDate": this.debtDeadlineDate,
        "priority": this.priority,
        "iOwe": this.iOwe == true ? 1 : 0,
        "is_done": this.isDone == true ? 1 : 0,
      };
}