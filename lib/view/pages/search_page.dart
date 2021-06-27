import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late var textController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<AutoCompleteTextFieldState<String>>();

    var citys = [
      "Adana",
      "Adıyaman",
      "Afyon",
      "Ağrı",
      "Amasya",
      "Ankara",
      "Antalya",
      "Artvin",
      "Aydın",
      "Balıkesir",
      "Bilecik",
      "Bingöl",
      "Bitlis",
      "Bolu",
      "Burdur",
      "Bursa",
      "Çanakkale",
      "Çankırı",
      "Çorum",
      "Denizli",
      "Diyarbakır",
      "Edirne",
      "Elazığ",
      "Erzincan",
      "Erzurum",
      "Eskişehir",
      "Gaziantep",
      "Giresun",
      "Gümüşhane",
      "Hakkari",
      "Hatay",
      "Isparta",
      "İçel (Mersin)",
      "İstanbul",
      "İzmir",
      "Kars",
      "Kastamonu",
      "Kayseri",
      "Kırklareli",
      "Kırşehir",
      "Kocaeli",
      "Konya",
      "Kütahya",
      "Malatya",
      "Manisa",
      "Kahramanmaraş",
      "Mardin",
      "Muğla",
      "Muş",
      "Nevşehir",
      "Niğde",
      "Ordu",
      "Rize",
      "Sakarya",
      "Samsun",
      "Siirt",
      "Sinop",
      "Sivas",
      "Tekirdağ",
      "Tokat",
      "Trabzon",
      "Tunceli",
      "Şanlıurfa",
      "Uşak",
      "Van",
      "Yozgat",
      "Zonguldak",
      "Aksaray",
      "Bayburt",
      "Karaman",
      "Kırıkkale",
      "Batman",
      "Şırnak",
      "Bartın",
      "Ardahan",
      "Iğdır",
      "Yalova",
      "Karabük",
      "Kilis",
      "Osmaniye",
      "Düzce"
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SimpleAutoCompleteTextField(
                  controller: textController,
                  suggestions: citys,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "enter a city",
                    labelText: "city name",
                  ),
                  key: key,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Get.back(result: textController.text.trim());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
