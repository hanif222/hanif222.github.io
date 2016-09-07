# HANIF PROJECT UI

[![Download Extension V1.3.1](https://dl.dropboxusercontent.com/u/165535097/Image/btn-download-gmez.svg)][btn-download-gmez]
[![Download GML File](https://dl.dropboxusercontent.com/u/165535097/Image/btn-download-gml.svg)][btn-download-gml]
[![Download Compressed Game Maker Source](https://dl.dropboxusercontent.com/u/165535097/Image/btn-download-gmz.svg)][btn-download-gmz]

[btn-download-gmez]: https://drive.google.com/open?id=0B4dj7Xx1JbgQakxkSy14djBkUWs
[btn-download-gml]: https://drive.google.com/open?id=0B4dj7Xx1JbgQT013RmJQal9OUVE
[btn-download-gmz]: https://drive.google.com/open?id=0B4dj7Xx1JbgQZ2Q2QkFlRXFpZTQ

## Pengenalan

***Hanif Project UI*** adalah sebuah kumpulan fungsi ekstensi yang dibangun dengan bahasa **GML** (*Game Maker Language*). Tujuannya tidak lain dan tidak bukan adalah untuk mempermudah dalam pengembangan game khusuhnya pada bagian UI. Kelebihan ***Hanif Project UI*** ini adalah tidak memerlukan sprite tambahan untuk memakainya.

## Penginstalan

Untuk menggunakan ekstensi ini, cukup mudah kita hanya tinggal *Drag and Drop* saja file **HanifProjectUI_v13.gmez** pada *IDE* **Game Maker:Studio** maka fungsi-fungsi baru akan ditambahkan.

Atau bisa juga dengan cara seperti berikut.
* Klik pada resource **Extension**
* Pilih menu **import Extension**

![Gambar 1](https://dl.dropboxusercontent.com/u/165535097/Image/ss0.jpg)

## Fungsi

***Hanif Project UI*** menggunakan prefix *hanif_* dalam setiap fungsinya untuk mempermudah dalam pengelompokkan fungsi-fungsi ekstensi.

### *hanif_control_start()*

Inisialisasi fungsi sebelum memanggil fungsi yang lain. Secara otomatis, jika menggunakan *extension* kita sudah memanggil fungsi ini, jadi tidak perlu lagi memanggil fungsi ini.
```
hanif_control_start();
```

### *hanif_control_end()*

Finalisasi fungsi setelah memanggil fungsi yang lain dan menghancurkan semua kontrol. Secara otomatis, jika menggunakan *extension* kita sudah memanggil fungsi ini juga.
```
hanif_control_end();
```

### *hanif_control_exist()*

Untuk mengecek apakah kontrol ada atau tidak. Fungsi ini akan menghasilkan nilai **true** jika kontrol ada dan **false** jika tidak..
```
hanif_control_exist(button0);
```

### *hanif_control_is_enable(handle[real])*

Mengecek apakah kontrol dalam keadaan *enable* atau *disable*. Fungsi ini akan menghasilkan nilai balik **true** jika *enable* dan **false** jika tidak.
```
if(hanif_control_is_enable(button0)){
  show_debug_message("Kontrol dalam keadaan enable.");
}
```

### *hanif_control_set_enable(handle[real], enable[boolean])*

Mengatur suatu kontrol ke keadaan *enable* atau *disable*.
```
if(hanif_control_is_enable(button0)){
  hanif_control_set_enable(button0, false);
}
```

### *hanif_control_is_focus(handle[real])*

Mengecek apakah suatu kontrol dalam keadaan fokus atau tidak. Fungsi ini akan menghasilkan nilai balik **true** jika fokus dan **false** jika tidak.
```
if(hanif_control_is_focus(button0)){
  show_debug_message("Kontrol dalam keadaan fokus.");
}
```

### *hanif_control_set_focus(handle[real])*

Set fokus pada suatu kontrol dan menghilangkan status fokus pada kontrol lain.
```
hanif_control_set_focus(button0);
```

### *hanif_control_set_color(handle[real], color[real])*

Mengatur warna suatu kontrol.
```
hanif_control_set_color(button0, c_teal);
```

### *hanif_control_set_padding(handle[real], padding[real])*

Mengatur lebar padding suatu kontrol.
```
hanif_control_set_padding(button0, 8);
```

### *hanif_control_set_position(handle[real], x[real], y[real])*

Mengatur posisi pada suatu kontrol dengan memberikan *argument* x dan y yang diinginkan.
```
hanif_control_set_position(button0, 32, 64);
```

### *hanif_control_set_size(handle[real], width[real], height[real])*

Mengatur lebar dan panjang suatu kontrol.
```
hanif_control_set_size(button0, 128, 24);
```

### *hanif_control_set_text(handle[real], text[string])*

Mengatur property text pada kontrol.
```
hanif_control_set_text(button0, "Mainkan");
```

### *hanif_control_destroy(handle[real])*

Menghapus handle pada suatu kontrol.
```
hanif_control_destroy(button0);
```

### *hanif_button_create(x[real], y[real], width[real], height[real], text[string])*

Membuat kontrol tombol baru. *Argument* **width** dan **height** dapat bernilai **-1** untuk secara otomatis menyesuaikan panjang huruf. Fungsi ini akan menghasilkan **handle** berupa *ds_map*.
```
button0 = hanif_button_create(32, 32, 128, 18, "TOMBOL");
```

### *hanif_button_step(handle[real])*

Mengatur tombol agar fungsi-fungsinya dapat dijalankan seperti klik dan fokus. Fungsi ini juga digunakan untuk mengecek apakah tombol sedang ditekan atau tidak.
```
if(hanif_button_step(button0)){
  show_debug_message("Tombol ditekan!");
}
```

### *hanif_button_draw(handle[real])*

Digunakan untuk menggambar tombol. Disarankan menggunakan event **Draw GUI** untuk menghindari tertindih dengan draw lain dan view. 
```
hanif_button_draw(button0);
```

### *hanif_button_draw(handle[real])*

Digunakan untuk menggambar tombol. Disarankan menggunakan event **Draw GUI** untuk menghindari tertindih dengan draw lain dan view. 
```
hanif_button_draw(button0);
```

### *hanif_textbox_create(x[real], y[real], width[real], height[real])*

Membuat kontrol textbox baru. Fungsi ini akan menghasilkan **handle** berupa *ds_map*.
```
textbox0 = hanif_textbox_create(32, 64, 128, 18);
```

### *hanif_textbox_set_maxchar(handle[real], maxchar[real])*

Untuk memberi batasan jumlah karakter yang bisa diketikkan dalam textbox.
```
hanif_textbox_set_maxchar(textbox0, 10);
```

### *hanif_textbox_set_password(handle[real])*

Menjadikan seuatu kontrol textbox menjadi textbox password (menggantikan karakter yang dimasukkan dengan '*').
```
hanif_textbox_set_password(textbox0);
```

### *hanif_textbox_set_label(handle[real], label[string])*

Memberikan text label ke suatu textbox. Label akan muncul jika textbox kosong dan tidak fokus.
```
hanif_textbox_set_label(textbox0, "Username");
```

### *hanif_textbox_set_value(handle[real], value[string])*

Mengatur text pada textbox.
```
hanif_textbox_set_value(textbox0, "Muharif Al Hanif");
```

### *hanif_textbox_get_value(handle[real])*

Mendapatkan value pada suatu textbox. Fungsi ini akan menghasilkan nilai berupa *string*.
```
hanif_textbox_get_value(textbox0);
```

### *hanif_textbox_step(handle[real])*

Mengatur textbox agar fungsi-fungsinya dapat dijalankan seperti klik dan fokus serta bisa diketik.
```
hanif_textbox_step(textbox0);
```

### *hanif_textbox_draw(handle[real])*

Digunakan untuk menggambar textbox. Disarankan menggunakan event **Draw GUI** untuk menghindari tertindih dengan draw lain dan view. 
```
hanif_textbox_draw(textbox0);
```

### *hanif_checkbox_create(x[real], y[real], text[string])*

Membuat kontrol checkbox baru. Fungsi ini akan menghasilkan **handle** berupa *ds_map*.
```
checkbox0 = hanif_checkbox_create(32, 96, "Auto Login");
```

### *hanif_checkbox_set_size(handle[real], size[real])*

Mengubah ukuran checkbox.
```
hanif_checkbox_set_size(checkbox0, 16);
```

### *hanif_checkbox_is_checked(handle[real])*

Mengecek apakah checkbox dicentang atau tidak. Fungsi ini akan menghasilkan nilai **true** apabila checkbox tercentang dan **false** apabila tidak.
```
if(hanif_checkbox_is_checked(checkbox0)){
  show_debug_message("Checkbox tercentang.");
}
```

### *hanif_checkbox_set_checked(handle[real], checked[boolean])*

Mengubah suatu checkbox menjadi tercentang atau tidak.
```
if(!hanif_checkbox_is_checked(checkbox0)){
  hanif_checkbox_set_checked(checkbox0, true);
}
```

### *hanif_checkbox_step(handle[real])*

Mengatur checkbox agar fungsi-fungsinya dapat dijalankan dapat dicentang atau tidak.
```
hanif_checkbox_step(checkbox0);
```

### *hanif_checkbox_draw(handle[real])*

Digunakan untuk menggambar checkbox. Disarankan menggunakan event **Draw GUI** untuk menghindari tertindih dengan draw lain dan view.
```
hanif_checkbox_draw(checkbox0);
```

### *hanif_radio_grup_create()*

Tidak seperti checkbox, untuk tombol radio diperlukan sebuah grup untuk menghindari konflik dengan tombol radio pada grup yang berbeda. Fungsi ini akan menghasilkan **handle** berupa *ds_list*.
```
groupRadio0 = hanif_radio_grup_create();
```

### *hanif_radio_grup_step(handle[real])*

Untuk mengatur agar fungsi-fungsi grup tombol radio dapat dijalankan.
```
hanif_radio_grup_step(groupRadio0);
```

### *hanif_radio_grup_get_checked(handle[real])*

Untuk mengetahui tombol radio mana yang tercentang dalam satu grup.
```
if(hanif_radio_grup_get_checked(groupRadio0) == radio0){
  show_debug_message("Tombol radio 0 tercentang!");
}
```

### *hanif_radio_create(x[real], y[real], text[string], group[real])*

Membuat kontrol tombol radio baru. Fungsi ini akan menghasilkan **handle** berupa *ds_map*.
```
radio0 = hanif_radio_create(32, 96, "Male", groupRadio0);
radio1 = hanif_radio_create(148, 96, "Female", groupRadio0);
```


### *hanif_radio_set_size(handle[real], size[real])*

Mengubah ukuran radio.
```
hanif_radio_set_size(radio0, 16);
```

### *hanif_radio_is_checked(handle[real])*

Mengecek apakah radio dicentang atau tidak. Fungsi ini akan menghasilkan nilai **true** apabila radio tercentang dan **false** apabila tidak.
```
if(hanif_radio_is_checked(radio0)){
  show_debug_message("Tombol Radio 0 tercentang.");
}
```

### *hanif_radio_set_checked(handle[real], checked[boolean])*

Mengubah suatu tombol radio menjadi tercentang atau tidak.
```
hanif_radio_set_checked(radio1, false);
```

### *hanif_radio_step(handle[real])*

Mengatur tombol radio agar fungsi-fungsinya dapat dijalankan dapat dicentang atau tidak.
```
hanif_radio_step(radio0);
hanif_radio_step(radio1);
```

### *hanif_radio_draw(handle[real])*

Digunakan untuk menggambar tombol radio. Disarankan menggunakan event **Draw GUI** untuk menghindari tertindih dengan draw lain dan view.
```
hanif_radio_draw(radio0);
hanif_radio_draw(radio1);
```

### *hanif_dropdown_create(x[real], y[real], width[real], height[real])*

Membuat kontrol dropdown baru. Fungsi ini akan menghasilkan **handle** berupa *ds_map*.
```
dropdown0 = hanif_dropdown_create(148, 32, 308, 18);
```

### *hanif_dropdown_add_item(handle[real], text[string])*

Menambahkan item ke kontrol dropdown.
```
item0 = hanif_dropdown_add_item(dropdown0, "Jakarta");
item1 = hanif_dropdown_add_item(dropdown0, "Surabaya");
item2 = hanif_dropdown_add_item(dropdown0, "Jogjakarta");
item3 = hanif_dropdown_add_item(dropdown0, "Denpasar");
item4 = hanif_dropdown_add_item(dropdown0, "Palembang");
```

### *hanif_dropdown_delete_item(handle[real], handle[real])*

Menghaspus item dari kontrol dropdown. *Argument* **handle** pertama adalah kontrol dropdown, sedangankan **handle** kedua adalah item yang akan dihapus.
```
hanif_dropdown_delete_item(dropdown0, item1);
```

### *hanif_dropdown_get_selected(handle[real])*

Mengembalikan *handle* item yang terpilih.
```
if(hanif_dropdown_get_selected(dropdown0) == item0){
  show_debug_message("Anda memilih Jakarta.");
}
```

### *hanif_dropdown_get_selected_text(handle[real])*

Mengembalikan text dari *handle* item yang terpilih.
```
var kota;
kota = hanif_dropdown_get_selected_text(dropdown0);
show_debug_message("Anda memilih" + kota);
```

### *hanif_dropdown_step(handle[real])*

Mengatur agar fungsi-fungsi dropdown dapat dijalankan seperti membuka atau menutup dropdown.
```
hanif_dropdown_step(dropdown0);
```

### *hanif_dropdown_draw(handle[real])*

Digunakan untuk menggambar dropdown. Disarankan menggunakan event **Draw GUI End** untuk menghindari tertindih dengan draw lain atau GUI lain dan view.
```
hanif_dropdown_draw(dropdown0);
```

## Changelog

```
V 1.0
-----------------------------------
* Pembuatan kontrol textbox
* Pembuatan kontrol button

V 1.1
-----------------------------------
* Pembuatan global
* Fix beberapa bug

V 1.2
-----------------------------------
* Pembuatan kontrol checkbox
* Pembuatan kontrol tombol radio
* Fix beberapa bug
* Pembuatan ekstensi

V 1.3
-----------------------------------
* Perubahan external name
* Pembuatan kontrol dropdown
* Penambahan fungsi inisialisasi
* Fix beberapa bug
```
