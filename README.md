# [hanifui.github.io]

[![Download versi terbaru](https://dl.dropboxusercontent.com/u/165535097/Image/btn-download.svg)][btn-download]

[btn-download]: https://drive.google.com/open?id=0B4dj7Xx1JbgQSXZkaG1jaUZfeTA

## Pengenalan

***Hanif Project UI*** adalah sebuah kumpulan fungsi ekstesi yang dibangun dengan bahasa **GML** (*Game Maker Language*). Tujuannya tidak lain dan tidak bukan adalah untuk mempermudah dalam pengembangan game khusuhnya pada bagian UI. Kelebihan ***Hanif Project UI*** ini adalah tidak memerlukan sprite tambahan untuk memakainya.

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

### *hanif_control_end()*

Finalisasi fungsi setelah memanggil fungsi yang lain dan menghancurkan semua kontrol. Secara otomatis, jika menggunakan *extension* kita sudah memanggil fungsi ini juga.

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

Membuat kontrol tombol baru. *Argument* **width** dan **height** dapat bernilai **-1** untuk secara otomatis menyesuaikan panjang huruf. Fungsi ini akan menghasilkan **handle** berupa *ds_map*
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
