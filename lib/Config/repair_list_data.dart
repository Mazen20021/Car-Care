class GasItem {
  String name;
  String date;
  String km;
  String cost;

  GasItem({
    required this.name,
    required this.date,
    required this.km,
    required this.cost,
  });
}
class RepairItem
{
  String name;
  String id;
  String reminderKm;
  String profileId;
  RepairItem({
    required this.name,
    required this.id,
    required this.reminderKm,
    required this.profileId,
  });
}