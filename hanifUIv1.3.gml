#define hanif_control_start
globalvar hanifProjectUIControls;
hanifProjectUIControls = ds_list_create();

show_debug_message("Hanif Project UI : Started!");
return true;

#define hanif_control_end
if(is_undefined(hanifProjectUIControls)){
    return false;
}
else{
    for(i=0;i<ds_list_size(hanifProjectUIControls);i++){
        hanif_control_destroy(hanifProjectUIControls[| i]);
    }
    
    hanif_control_destroy(hanifProjectUIControls);
    
    show_debug_message("Hanif Project UI : Ended!");
    return true;
}

#define hanif_control_is_enable
var handle, enable;
handle = argument[0];

if(handle == -1){
    return false;
}
else{
    if(ds_map_exists(handle, "enable")){
        enable = handle[? "enable"];
        
        if(enable){
            return true;
        }
        else{
            return false;
        }
    }
    else{
        return false;
    }
}

#define hanif_control_set_color
var handle, color;

handle = argument[0];
color = argument[1];

if(handle == -1){
    return false;
}
else{
    if(ds_map_exists(handle, "color")){
        ds_map_replace(handle, "color", color);
        return true;
    }
    else{
        return false;
    }
}

#define hanif_control_set_padding
var handle, padding;

handle = argument[0];
padding = argument[1];

if(handle == -1){
    return false;
}
else{
    if(ds_map_exists(handle, "padding")){
        ds_map_replace(handle, "padding", padding);
        return true;
    }
    else{
        return false;
    }
}

#define hanif_control_set_enable
var handle, enable;

handle = argument[0];
enable = argument[1];

if(handle == -1){
    return false;
}
else{
    if(ds_map_exists(handle, "enable")){
        ds_map_replace(handle, "enable", enable);
        return true;
    }
    else{
        return false;
    }
}

#define hanif_control_set_position
var handle, posX, posY;

handle = argument[0];
posX = argument[1];
posY = argument[2];

if(handle == -1){
    return false;
}
else{
    if(ds_map_exists(handle, "x") && ds_map_exists(handle, "y")){
        ds_map_replace(handle, "x", posX);
        ds_map_replace(handle, "y", posY);
        return true;
    }
    else{
        return false;
    }
}

#define hanif_control_set_size
var handle, width, height;

handle = argument[0];
width = argument[1];
height = argument[2];

if(handle == -1){
    return false;
}
else{
    if(ds_map_exists(handle, "width") && ds_map_exists(handle, "height")){
        ds_map_replace(handle, "width", width);
        ds_map_replace(handle, "height", height);
        return true;
    }
    else{
        return false;
    }
}

#define hanif_control_set_text
var handle, text;

handle = argument[0];
text = argument[1];

if(handle == -1){
    return false;
}
else{
    if(ds_map_exists(handle, "text")){
        ds_map_replace(handle, "text", width);
        return true;
    }
    else{
        return false;
    }
}

#define hanif_control_is_focus
var handle, enable;
handle = argument[0];

if(handle == -1){
    return false;
}
else{
    if(ds_map_exists(handle, "focus")){
        enable = handle[? "focus"];
        
        if(enable){
            return true;
        }
        else{
            return false;
        }
    }
    else{
        return false;
    }
}

#define hanif_control_set_focus
var handle;

handle = argument[0];

if(handle == -1){
    return false;
}
else{
    if(ds_map_exists(handle, "focus")){
        for(i=0;i<ds_list_size(hanifProjectUIControls);i++){
            var curControl
            curControl = hanifProjectUIControls[| i];
            if(curControl != handle){
                if(ds_map_exists(curControl, "focus")){
                    ds_map_replace(curControl, "focus", false);
                }
            }
        }
        ds_map_replace(handle, "focus", true);
        return true;
    }
    else{
        return false;
    }
}

#define hanif_control_destroy
var handle;
handle = argument[0];

if(handle == -1){
    return false;
}
else{
    if(ds_exists(handle, ds_type_map)){
        ds_map_destroy(handle);
    }
    else if(ds_exists(handle, ds_type_list)){
        ds_list_destroy(handle);
    }
    else{
        return false;
    }
}

#define hanif_button_create
var posX, posY, text, width, height, properties;
posX = argument[0];
posY = argument[1];
width = argument[2];
height = argument[3];
text = argument[4];
properties = ds_map_create();

if(is_undefined(hanifProjectUIControls)){
    show_debug_message("Hanif Project UI: Initialize failed!");
    return false;
}
else{
    if(is_undefined(posX) or is_undefined(posY) or is_undefined(text)){
        return -1;
    }
    else{
        ds_map_add(properties, "x", posX);
        ds_map_add(properties, "y", posY);
        ds_map_add(properties, "width", width);
        ds_map_add(properties, "height", height);
        ds_map_add(properties, "text", text);
        ds_map_add(properties, "color", c_silver);
        ds_map_add(properties, "padding", 8);
        ds_map_add(properties, "enable", true);
        ds_map_add(properties, "clicked", false);
        ds_map_add(properties, "focus", false);
        
        ds_list_add(hanifProjectUIControls, properties);
        
        return properties;
    }
}

#define hanif_button_draw
var handle, posX, posY, text, color, color0, color1, color2, padding, enable, focus, width, height;

handle = argument[0];

if(handle == -1){
    return false;
}
else{
    posX = handle[? "x"];
    posY = handle[? "y"];
    text = handle[? "text"];
    color = handle[? "color"];
    padding = handle[? "padding"];
    enable = handle[? "enable"];
    focus = handle[? "focus"];
    width = handle[? "width"];
    height = handle[? "height"];
    if(width == -1) width = string_width(text);
    if(height == -1) height = string_height(text);
    
    color0 = make_colour_hsv(colour_get_hue(color), colour_get_saturation(color), min(colour_get_value(color) + 25, 255));
    color1 = make_colour_hsv(colour_get_hue(color), colour_get_saturation(color), max(colour_get_value(color) - 50, 0));
    if(colour_get_value(color) > 128){
        color2 = c_black;
        color3 = c_white;
    }
    else{
        color2 = c_white;
        color3 = c_black;
    }
    
    if(enable){
        if(focus){
            draw_set_alpha(0.3);
            draw_roundrect_colour_ext(posX - 4, posY - 4, posX + width + padding + 4, posY + height + padding + 4, 8, 8, c_blue, c_blue, false);
            draw_set_alpha(0.4);
            draw_roundrect_colour_ext(posX - 3, posY - 3, posX + width + padding + 3, posY + height + padding + 3, 8, 8, c_white, c_white, false);
            draw_set_alpha(1);
        }
        else{
            draw_set_alpha(0.1);
            draw_roundrect_colour_ext(posX - 3, posY - 3, posX + width + padding + 3, posY + height + padding + 3, 8, 8, c_black, c_black, false);
            draw_set_alpha(1);
        }
                
        if(device_mouse_x_to_gui(0) > posX && device_mouse_y_to_gui(0) > posY && device_mouse_x_to_gui(0) < posX + width + padding && device_mouse_y_to_gui(0) < posY + height + padding){
            if(device_mouse_check_button(0, mb_left)){
                draw_roundrect_colour_ext(posX - 2, posY - 2, posX + width + padding, posY + height + padding, 8, 8, color1, color1, false);
                draw_roundrect_colour_ext(posX, posY, posX + width + padding + 2, posY + height + padding + 2, 8, 8, color0, color0, false);
                draw_roundrect_colour_ext(posX, posY, posX + width + padding, posY + height + padding, 8, 8, color, color, false);
                draw_set_alpha(0.3);
                draw_roundrect_colour_ext(posX, posY, posX + width + padding, posY + height + padding, 8, 8, c_black, c_black, false);
                draw_set_alpha(1);
            }
            else{
                draw_roundrect_colour_ext(posX - 2, posY - 2, posX + width + padding, posY + height + padding, 8, 8, color0, color0, false);
                draw_roundrect_colour_ext(posX, posY, posX + width + padding + 2, posY + height + padding + 2, 8, 8, color1, color1, false);
                draw_roundrect_colour_ext(posX, posY, posX + width + padding, posY + height + padding, 8, 8, color, color, false);
                draw_set_alpha(0.3);
                draw_roundrect_colour_ext(posX, posY, posX + width + padding, posY + height + padding, 8, 8, c_white, c_white, false);
                draw_set_alpha(1);
            }
        }
        else{
            draw_roundrect_colour_ext(posX - 2, posY - 2, posX + width + padding, posY + height + padding, 8, 8, color0, color0, false);
            draw_roundrect_colour_ext(posX, posY, posX + width + padding + 2, posY + height + padding + 2, 8, 8, color1, color1, false);
            draw_roundrect_colour_ext(posX, posY, posX + width + padding, posY + height + padding, 8, 8, color, color, false);
        }
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text_colour(posX + (width + padding)/2 + 1, posY + (height + padding)/2 + 2, text, color3, color3, color3, color3, 0.3);
        draw_text_colour(posX + (width + padding)/2, posY + (height + padding)/2, text, color2, color2, color2, color2, 1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
    else{
        draw_roundrect_colour_ext(posX - 2, posY - 2, posX + width + padding + 2, posY + height + padding + 2, 8, 8, c_dkgray, c_dkgray, false);
        draw_roundrect_colour_ext(posX, posY, posX + width + padding, posY + height + padding, 8, 8, c_gray, c_gray, false);
            
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text_colour(posX + (width + padding)/2, posY + (height + padding)/2, text, c_silver, c_silver, c_silver, c_silver, 1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
}

#define hanif_button_step
var handle, posX, posY, width, height, text, clicked, enable, focus;
handle = argument[0];

if(is_undefined(hanifProjectUIControls)){
    show_debug_message("Hanif Project UI: Initialize failed!");
    return false;
}
else{
    if(handle == -1){
        return false;
    }
    else{
        posX = handle[? "x"];
        posY = handle[? "y"];
        text = handle[? "text"];
        padding = handle[? "padding"];
        clicked = handle[? "clicked"];
        enable = handle[? "enable"];
        focus = handle[? "focus"];
        width = handle[? "width"];
        height = handle[? "height"];
        if(width == -1) width = string_width(text);
        if(height == -1) height = string_height(text);
        
        if(enable){
            var noActiveControl;
            noActiveControl = true;
            for(i=0;i<ds_list_size(hanifProjectUIControls);i++){
                if(ds_exists(hanifProjectUIControls[| i], ds_type_map)){
                    var existControl;
                    existControl = hanifProjectUIControls[| i];
                    if(existControl[? "open"]){
                        noActiveControl = false;
                        break;
                    }
                }
            }
            if(noActiveControl){
                if(keyboard_check(vk_enter) && focus){
                    show_debug_message("Hanif Project UI:  control '" + string(handle) + "' clicked!");
                    return true;
                }
                else{
                    if(device_mouse_x_to_gui(0) > posX && device_mouse_y_to_gui(0) > posY && device_mouse_x_to_gui(0) < posX + width + padding && device_mouse_y_to_gui(0) < posY + height + padding){
                        
                        if(device_mouse_check_button_pressed(0, mb_left)){
                            ds_map_replace(handle, "clicked", true);
                        }
                        if(device_mouse_check_button_released(0, mb_left) && clicked){
                            ds_map_replace(handle, "clicked", false);
                            if(!focus){
                                ds_map_replace(handle, "focus", true);
                                show_debug_message("Hanif Project UI:  control '" + string(handle) + "' is focused now!");
                            }
                            show_debug_message("Hanif Project UI:  control '" + string(handle) + "' clicked!");
                            return true;
                        }
                    }
                    else{
                        ds_map_replace(handle, "clicked", false);
                        if(device_mouse_check_button_pressed(0, mb_left)){
                            if(focus){
                                ds_map_replace(handle, "focus", false);
                            }
                        }
                        return false;
                    }
                }
            }
            else{
                return false;
            }
        }
    }
}

#define hanif_textbox_create
var posX, posY, width, height, properties;
posX = argument[0];
posY = argument[1];
width = argument[2];
height = argument[3];
properties = ds_map_create();

if(is_undefined(hanifProjectUIControls)){
    show_debug_message("Hanif Project UI: Initialize failed!");
    return false;
}
else{
    if(is_undefined(posX) or is_undefined(posY) or is_undefined(width) or is_undefined(height)){
        return -1;
    }
    else{
        ds_map_add(properties, "x", posX);
        ds_map_add(properties, "y", posY);
        ds_map_add(properties, "width", width);
        ds_map_add(properties, "height", height);
        ds_map_add(properties, "maxchar", 255);
        ds_map_add(properties, "password", false);
        ds_map_add(properties, "color", c_silver);
        ds_map_add(properties, "label", "");
        ds_map_add(properties, "value", "");
        ds_map_add(properties, "padding", 8);
        ds_map_add(properties, "clicked", false);
        ds_map_add(properties, "enable", true);
        ds_map_add(properties, "focus", false);
        
        ds_list_add(hanifProjectUIControls, properties);
        
        return properties;
    }
}

#define hanif_textbox_set_maxchar
var handle, color;

handle = argument[0];
maxchar = argument[1];

if(handle == -1){
    return false;
}
else{
    ds_map_replace(handle, "maxchar", maxchar);
    return true;
}

#define hanif_textbox_set_password
var handle;

handle = argument[0];

if(handle == -1){
    return false;
}
else{
    ds_map_replace(handle, "password", true);
    return true;
}

#define hanif_textbox_set_label
var handle, label;

handle = argument[0];
label = argument[1];

if(handle == -1){
    return false;
}
else{
    ds_map_replace(handle, "label", label);
    return true;
}

#define hanif_textbox_set_value
var handle, value;

handle = argument[0];
value = argument[1];

if(handle == -1){
    return false;
}
else{
    ds_map_replace(handle, "value", value);
    return true;
}

#define hanif_textbox_get_value
var handle;

handle = argument[0];

if(handle == -1){
    return false;
}
else{
    return handle[? "value"];
}

#define hanif_textbox_step
var handle, posX, posY, text, clicked, maxchar, enable, focus, width, height;
handle = argument[0];

if(is_undefined(hanifProjectUIControls)){
    show_debug_message("Hanif Project UI: Initialize failed!");
    return false;
}
else{
    if(handle == -1){
        return false;
    }
    else{
        posX = handle[? "x"];
        posY = handle[? "y"];
        width = handle[? "width"];
        height = handle[? "height"];
        maxchar = handle[? "maxchar"];
        padding = handle[? "padding"];
        clicked = handle[? "clicked"];
        enable = handle[? "enable"];
        focus = handle[? "focus"];
        
        if(enable){
            var noActiveControl;
                noActiveControl = true;
                for(i=0;i<ds_list_size(hanifProjectUIControls);i++){
                    if(ds_exists(hanifProjectUIControls[| i], ds_type_map)){
                        var existControl;
                        existControl = hanifProjectUIControls[| i];
                        if(existControl[? "open"]){
                            noActiveControl = false;
                            break;
                        }
                    }
                }
            if(noActiveControl){
                if(keyboard_check(vk_anykey) && focus){
                    if(keyboard_check_pressed(vk_backspace)){
                        var value;
                        value = handle[? "value"];
                        ds_map_replace(handle, "value", string_copy(value, 1, string_length(value) - 1));
                    }
                    else{
                        var value;
                        value = handle[? "value"];
                        if(string_length(value) < maxchar){
                            value += keyboard_string;
                            ds_map_replace(handle, "value", value);
                        }
                        keyboard_string = "";
                    }
                }
                else if(device_mouse_x_to_gui(0) > posX && device_mouse_y_to_gui(0) > posY && device_mouse_x_to_gui(0) < posX + width + padding && device_mouse_y_to_gui(0) < posY + height + padding){
                    if(device_mouse_check_button_pressed(0, mb_left)){
                        ds_map_replace(handle, "clicked", true);
                    }
                    if(device_mouse_check_button_released(0, mb_left) && clicked){
                        ds_map_replace(handle, "clicked", false);
                        if(!focus){
                            ds_map_replace(handle, "focus", true);
                            show_debug_message("Hanif Project UI:  control '" + string(handle) + "' is focused now!");
                        }
                        keyboard_string = "";
                        show_debug_message("Hanif Project UI:  control '" + string(handle) + "' clicked!");
                        return true;
                    }
                }
                else{
                    ds_map_replace(handle, "clicked", false);
                    if(device_mouse_check_button_pressed(0, mb_left)){
                        if(focus){
                            ds_map_replace(handle, "focus", false);
                        }
                    }
                    return false;
                }
            }
            else{
                return false;
            }
        }
    }
}

#define hanif_textbox_draw
var handle, posX, posY, width, height, password, value, label, color, color1, color2, color3, enable, focus;

handle = argument[0];

if(handle == -1){
    return false;
}
else{
    posX = handle[? "x"];
    posY = handle[? "y"];
    width = handle[? "width"];
    height = handle[? "height"];
    password = handle[? "password"];
    value = handle[? "value"];
    label = handle[? "label"];
    padding = handle[? "padding"];
    enable = handle[? "enable"];
    color = handle[? "color"];
    focus = handle[? "focus"];
    
    color0 = make_colour_hsv(colour_get_hue(color), colour_get_saturation(color), max(colour_get_value(color) - 50, 0));
    color1 = make_colour_hsv(colour_get_hue(color), colour_get_saturation(color), min(colour_get_value(color) + 25, 255));
    if(colour_get_value(color) > 128){
        color2 = c_black;
        color3 = c_white;
    }
    else{
        color2 = c_white;
        color3 = c_black;
    }
    
    if(enable){
        if(focus){
            draw_set_alpha(0.3);
            draw_roundrect_colour_ext(posX - 4, posY - 4, posX + width + padding + 4, posY + height + padding + 4, 8, 8, c_blue, c_blue, false);
            draw_set_alpha(0.4);
            draw_roundrect_colour_ext(posX - 3, posY - 3, posX + width + padding + 3, posY + height + padding + 3, 8, 8, c_white, c_white, false);
            draw_set_alpha(1);
        }
        else{
            draw_set_alpha(0.1);
            draw_roundrect_colour_ext(posX - 3, posY - 3, posX + width + padding + 3, posY + height + padding + 3, 8, 8, c_black, c_black, false);
            draw_set_alpha(1);
        }
                
        if(device_mouse_x_to_gui(0) > posX && device_mouse_y_to_gui(0) > posY && device_mouse_x_to_gui(0) < posX + width + padding && device_mouse_y_to_gui(0) < posY + height + padding){
            draw_roundrect_colour_ext(posX - 2, posY - 2, posX + width + padding, posY + height + padding, 8, 8, color0, color0, false);
            draw_roundrect_colour_ext(posX, posY, posX + width + padding + 2, posY + height + padding + 2, 8, 8, color1, color1, false);
            draw_roundrect_colour_ext(posX, posY, posX + width + padding, posY + height + padding, 8, 8, color, color, false);
            draw_set_alpha(0.3);
            draw_roundrect_colour_ext(posX, posY, posX + width + padding, posY + height + padding, 8, 8, c_white, c_white, false);
            draw_set_alpha(1);
        }
        else{
            draw_roundrect_colour_ext(posX - 2, posY - 2, posX + width + padding, posY + height + padding, 8, 8, color0, color0, false);
            draw_roundrect_colour_ext(posX, posY, posX + width + padding + 2, posY + height + padding + 2, 8, 8, color1, color1, false);
            draw_roundrect_colour_ext(posX, posY, posX + width + padding, posY + height + padding, 8, 8, color, color, false);
        }
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        if(password){
            var mask;
            mask = "";
            repeat(string_length(value)) mask+= '*';
            draw_text_ext_colour(posX + padding/2 + 1, posY + (height + padding)/2 + 2, mask, -1, width, color3, color3, color3, color3, 0.3);
            draw_text_ext_colour(posX + padding/2, posY + (height + padding)/2, mask, -1, width, color2, color2, color2, color2, 1);
            if(focus){
                draw_text_colour(posX + padding/2 + string_width_ext(value, -1, width) + 1, posY + (height + padding)/2 + 2, '|', color3, color3, color3, color3, 0.3);
                draw_text_colour(posX + padding/2 + string_width_ext(value, -1, width), posY + (height + padding)/2, '|', color2, color2, color2, color2, 1);
            }
        }
        else{
            draw_text_ext_colour(posX + padding/2 + 1, posY + (height + padding)/2 + 2, value, -1, width, color3, color3, color3, color3, 0.3);
            draw_text_ext_colour(posX + padding/2, posY + (height + padding)/2, value, -1, width, color2, color2, color2, color2, 1);
            if(focus){
                draw_text_colour(posX + padding/2 + string_width_ext(value, -1, width) + 1, posY + (height + padding)/2 + 2, '|', color3, color3, color3, color3, 0.3);
                draw_text_colour(posX + padding/2 + string_width_ext(value, -1, width), posY + (height + padding)/2, '|', color2, color2, color2, color2, 1);
            }
        }
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
    else{
        draw_roundrect_colour_ext(posX - 2, posY - 2, posX + width + padding + 2, posY + height + padding + 2, 8, 8, c_dkgray, c_dkgray, false);
        draw_roundrect_colour_ext(posX, posY, posX + width + padding, posY + height + padding, 8, 8, c_gray, c_gray, false);
            
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        if(password){
            var mask;
            mask = "";
            repeat(string_length(value)) mask+= '*';
            draw_text_ext_colour(posX + padding/2, posY + (height + padding)/2, mask, -1, width, c_silver, c_silver, c_silver, c_silver, 1);
        }
        else{
            draw_text_ext_colour(posX + padding/2, posY + (height + padding)/2, value, -1, width, c_silver, c_silver, c_silver, c_silver, 1);
        }
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
    
    if(!focus){
        if(value == ""){
            draw_set_halign(fa_left);
            draw_set_valign(fa_middle);
            draw_text_ext_colour(posX + padding/2, posY + (height + padding)/2, label, -1, width, color2, color2, color2, color2, 0.3);
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
        }
    }
}

#define hanif_checkbox_create
var posX, posY, text, properties;
posX = argument[0];
posY = argument[1];
text = argument[2];
properties = ds_map_create();

if(is_undefined(hanifProjectUIControls)){
    show_debug_message("Hanif Project UI: Initialize failed!");
    return false;
}
else{
    if(is_undefined(posX) or is_undefined(posY) or is_undefined(text)){
        return -1;
    }
    else{
        ds_map_add(properties, "x", posX);
        ds_map_add(properties, "y", posY);
        ds_map_add(properties, "text", text);
        ds_map_add(properties, "color", c_silver);
        ds_map_add(properties, "checked", true);
        ds_map_add(properties, "padding", 8);
        ds_map_add(properties, "size", 16);
        ds_map_add(properties, "clicked", false);
        ds_map_add(properties, "enable", true);
        ds_map_add(properties, "focus", false);
        
        ds_list_add(hanifProjectUIControls, properties);
        
        return properties;
    }
}

#define hanif_checkbox_step
var handle, posX, posY, checked, color, padding, enable, focus, size, size;

handle = argument[0];

if(is_undefined(hanifProjectUIControls)){
    return false;
}
else{
    if(is_undefined(hanifProjectUIControls)){
        show_debug_message("Hanif Project UI: Initialize failed!");
        return false;
    }
    else{
        if(handle == -1){
            return false;
        }
        else{
            posX = handle[? "x"];
            posY = handle[? "y"];
            padding = handle[? "padding"];
            enable = handle[? "enable"];
            checked = handle[? "checked"];
            clicked = handle[? "clicked"];
            focus = handle[? "focus"];
            size = handle[? "size"];
            
            if(enable){
                var noActiveControl;
                noActiveControl = true;
                for(i=0;i<ds_list_size(hanifProjectUIControls);i++){
                    if(ds_exists(hanifProjectUIControls[| i], ds_type_map)){
                        var existControl;
                        existControl = hanifProjectUIControls[| i];
                        if(existControl[? "open"]){
                            noActiveControl = false;
                            break;
                        }
                    }
                }
                if(noActiveControl){
                    if(keyboard_check_released(vk_enter) && focus){
                        ds_map_replace(handle, "checked", !checked);
                        if(checked){
                            show_debug_message("Hanif Project UI:  control '" + string(handle) + "' unchecked!");
                        }
                        else{
                            show_debug_message("Hanif Project UI:  control '" + string(handle) + "' checked!");
                        }
                        return true;
                    }
                    else{
                        if(device_mouse_x_to_gui(0) > posX && device_mouse_y_to_gui(0) > posY && device_mouse_x_to_gui(0) < posX + size + padding && device_mouse_y_to_gui(0) < posY + size + padding){
                            if(device_mouse_check_button_pressed(0, mb_left)){
                                ds_map_replace(handle, "clicked", true);
                            }
                            if(device_mouse_check_button_released(0, mb_left) && clicked){
                                ds_map_replace(handle, "clicked", false);
                                if(!focus){
                                    ds_map_replace(handle, "focus", true);
                                    show_debug_message("Hanif Project UI:  control '" + string(handle) + "' is focused now!");
                                }
                                ds_map_replace(handle, "checked", !checked);
                                if(checked){
                                    show_debug_message("Hanif Project UI:  control '" + string(handle) + "' unchecked!");
                                }
                                else{
                                    show_debug_message("Hanif Project UI:  control '" + string(handle) + "' checked!");
                                }
                                return true;
                            }
                        }
                        else{
                            ds_map_replace(handle, "clicked", false);
                            if(device_mouse_check_button_pressed(0, mb_left)){
                                if(focus){
                                    ds_map_replace(handle, "focus", false);
                                }
                            }
                            return false;
                        }
                    }
                }
                else{
                    return false;
                }
            }
        }
    }
}

#define hanif_checkbox_draw
var handle, posX, posY, text, checked, color, color0, color1, color2, padding, enable, focus, size, size;

handle = argument[0];

if(handle == -1){
    return false;
}
else{
    posX = handle[? "x"];
    posY = handle[? "y"];
    text = handle[? "text"];
    color = handle[? "color"];
    padding = handle[? "padding"];
    enable = handle[? "enable"];
    checked = handle[? "checked"];
    clicked = handle[? "clicked"];
    focus = handle[? "focus"];
    size = handle[? "size"];
    
    color0 = make_colour_hsv(colour_get_hue(color), colour_get_saturation(color), min(colour_get_value(color) + 25, 255));
    color1 = make_colour_hsv(colour_get_hue(color), colour_get_saturation(color), max(colour_get_value(color) - 50, 0));
    if(colour_get_value(color) > 128){
        color2 = c_black;
        color3 = c_white;
    }
    else{
        color2 = c_white;
        color3 = c_black;
    }
    
    if(enable){
        if(focus){
            draw_set_alpha(0.3);
            draw_roundrect_colour_ext(posX - 4, posY - 4, posX + size + padding + 4, posY + size + padding + 4, 8, 8, c_blue, c_blue, false);
            draw_set_alpha(0.4);
            draw_roundrect_colour_ext(posX - 3, posY - 3, posX + size + padding + 3, posY + size + padding + 3, 8, 8, c_white, c_white, false);
            draw_set_alpha(1);
        }
        else{
            draw_set_alpha(0.1);
            draw_roundrect_colour_ext(posX - 3, posY - 3, posX + size + padding + 3, posY + size + padding + 3, 8, 8, c_black, c_black, false);
            draw_set_alpha(1);
        }
        if(device_mouse_x_to_gui(0) > posX && device_mouse_y_to_gui(0) > posY && device_mouse_x_to_gui(0) < posX + size + padding && device_mouse_y_to_gui(0) < posY + size + padding){
            if(device_mouse_check_button(0, mb_left)){
                draw_roundrect_colour_ext(posX - 2, posY - 2, posX + size + padding, posY + size + padding, 8, 8, color1, color1, false);
                draw_roundrect_colour_ext(posX, posY, posX + size + padding + 2, posY + size + padding + 2, 8, 8, color0, color0, false);
                draw_roundrect_colour_ext(posX, posY, posX + size + padding, posY + size + padding, 8, 8, color, color, false);
                draw_set_alpha(0.3);
                draw_roundrect_colour_ext(posX, posY, posX + size + padding, posY + size + padding, 8, 8, c_black, c_black, false);
                draw_set_alpha(1);
            }
            else{
                draw_roundrect_colour_ext(posX - 2, posY - 2, posX + size + padding, posY + size + padding, 8, 8, color0, color0, false);
                draw_roundrect_colour_ext(posX, posY, posX + size + padding + 2, posY + size + padding + 2, 8, 8, color1, color1, false);
                draw_roundrect_colour_ext(posX, posY, posX + size + padding, posY + size + padding, 8, 8, color, color, false);
                draw_set_alpha(0.3);
                draw_roundrect_colour_ext(posX, posY, posX + size + padding, posY + size + padding, 8, 8, c_white, c_white, false);
                draw_set_alpha(1);
            }
        }
        else{
            draw_roundrect_colour_ext(posX - 2, posY - 2, posX + size + padding, posY + size + padding, 8, 8, color0, color0, false);
            draw_roundrect_colour_ext(posX, posY, posX + size + padding + 2, posY + size + padding + 2, 8, 8, color1, color1, false);
            draw_roundrect_colour_ext(posX, posY, posX + size + padding, posY + size + padding, 8, 8, color, color, false);
        }
        
        draw_set_alpha(0.25);
        draw_roundrect_colour_ext(posX + ((size + padding) / 2 - 10) + 2, posY + ((size + padding) / 2 - 10) + 2, posX + ((size + padding) / 2 - 10) + 20 - 2, posY + ((size + padding) / 2 - 10) + 20 - 2, 4, 4, color3, color3, false);
        draw_set_alpha(1);
        
        if(checked){
            draw_primitive_begin(pr_trianglestrip);
            draw_vertex_colour(posX + ((size + padding) / 2 - 10) + 4 + 1, posY + ((size + padding) / 2 - 12) + 11 + 2, color3, 0.2);
            draw_vertex_colour(posX + ((size + padding) / 2 - 10) + 9 + 1, posY + ((size + padding) / 2 - 12) + 20 + 2, color3, 0.2);
            draw_vertex_colour(posX + ((size + padding) / 2 - 10) + 9 + 1, posY + ((size + padding) / 2 - 12) + 13 + 2, color3, 0.2);
            draw_vertex_colour(posX + ((size + padding) / 2 - 10) + 20 + 1, posY + ((size + padding) / 2 - 12) + 3 + 2, color3, 0.2);
            draw_vertex_colour(posX + ((size + padding) / 2 - 10) + 9 + 1, posY + ((size + padding) / 2 - 12) + 13 + 2, color3, 0.2);
            draw_vertex_colour(posX + ((size + padding) / 2 - 10) + 9 + 1, posY + ((size + padding) / 2 - 12) + 20 + 2, color3, 0.2);
            draw_primitive_end();
            
            draw_primitive_begin(pr_trianglestrip);
            draw_vertex_colour(posX + ((size + padding) / 2 - 10) + 4, posY + ((size + padding) / 2 - 12) + 11, color2, 1);
            draw_vertex_colour(posX + ((size + padding) / 2 - 10) + 9, posY + ((size + padding) / 2 - 12) + 20, color2, 1);
            draw_vertex_colour(posX + ((size + padding) / 2 - 10) + 9, posY + ((size + padding) / 2 - 12) + 13, color2, 1);
            draw_vertex_colour(posX + ((size + padding) / 2 - 10) + 20, posY + ((size + padding) / 2 - 12) + 3, color2, 1);
            draw_vertex_colour(posX + ((size + padding) / 2 - 10) + 9, posY + ((size + padding) / 2 - 12) + 13, color2, 1);
            draw_vertex_colour(posX + ((size + padding) / 2 - 10) + 9, posY + ((size + padding) / 2 - 12) + 20, color2, 1);
            draw_primitive_end();
        }
    }
    else{
        draw_roundrect_colour_ext(posX - 2, posY - 2, posX + size + padding + 2, posY + size + padding + 2, 8, 8, c_dkgray, c_dkgray, false);
        draw_roundrect_colour_ext(posX, posY, posX + size + padding, posY + size + padding, 8, 8, c_gray, c_gray, false);
        
        draw_set_alpha(0.25);
        draw_roundrect_colour_ext(posX + ((size + padding) / 2 - 10) + 2, posY + ((size + padding) / 2 - 10) + 2, posX + ((size + padding) / 2 - 10) + 20 - 2, posY + ((size + padding) / 2 - 10) + 20 - 2, 4, 4, c_dkgray, c_dkgray, false);
        draw_set_alpha(1);
        
        if(checked){
            draw_primitive_begin(pr_trianglestrip);
            draw_vertex_colour(posX + ((size + padding) / 2 - 10) + 4, posY + ((size + padding) / 2 - 12) + 11, c_silver, 1);
            draw_vertex_colour(posX + ((size + padding) / 2 - 10) + 9, posY + ((size + padding) / 2 - 12) + 20, c_silver, 1);
            draw_vertex_colour(posX + ((size + padding) / 2 - 10) + 9, posY + ((size + padding) / 2 - 12) + 13, c_silver, 1);
            draw_vertex_colour(posX + ((size + padding) / 2 - 10) + 20, posY + ((size + padding) / 2 - 12) + 3, c_silver, 1);
            draw_vertex_colour(posX + ((size + padding) / 2 - 10) + 9, posY + ((size + padding) / 2 - 12) + 13, c_silver, 1);
            draw_vertex_colour(posX + ((size + padding) / 2 - 10) + 9, posY + ((size + padding) / 2 - 12) + 20, c_silver, 1);
            draw_primitive_end();
        }
    }
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_text_colour(posX + (size + padding) + 8, posY + (size + padding)/2, text, c_black, c_black, c_black, c_black, 1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

#define hanif_checkbox_is_checked
var handle;

handle = argument[0];

if(handle == -1){
    return false;
}
else{
    return handle[? "checked"];
}

#define hanif_checkbox_set_checked
var handle, checked;

handle = argument[0];
checked = argument[1];

if(handle == -1){
    return false;
}
else{
    ds_map_replace(handle, "checked", checked);
    return true;
}

#define hanif_checkbox_set_size
var handle, size;

handle = argument[0];
size = argument[1];

if(handle == -1){
    return false;
}
else{
    ds_map_replace(handle, "size", size);
    return true;
}

#define hanif_radio_grup_create
if(is_undefined(hanifProjectUIControls)){
    show_debug_message("Hanif Project UI: Initialize failed!");
    return false;
}
else{
    properties = ds_list_create();
    
    ds_list_add(hanifProjectUIControls, properties);
        
    return properties;
}

#define hanif_radio_grup_step
var handle;

handle = argument[0];

if(is_undefined(hanifProjectUIControls)){
    show_debug_message("Hanif Project UI: Initialize failed!");
    return false;
}
else{
    if(handle == -1){
        return false;
    }
    else{
        if(keyboard_check_pressed(vk_tab)){
            for(i=0;i<ds_list_size(handle);i++){
                var prop = handle[| i];
                if(ds_exists(prop, ds_type_map)){
                    if(ds_map_exists(prop, "focus")){
                        if(prop[? "focus"]){
                            var next = handle[| (i + 1) mod ds_list_size(handle)];
                            if(ds_map_exists(next, "focus")){
                                if(!next[? "focus"]){
                                    ds_map_replace(prop, "focus", false);
                                    ds_map_replace(next, "focus", true);
                                    show_debug_message("Hanif Project UI:  control '" + string(next) + "' is focused now!");
                                    break;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#define hanif_radio_grup_get_checked
var handle, checked;

handle = argument[0];
checked = -1;

if(handle == -1){
    return false;
}
else{
    for(i=0;i<ds_list_size(handle);i++){
        var prop = handle[| i];
        if(ds_exists(prop, ds_type_map)){
            if(ds_map_exists(prop, "checked")){
                if(prop[? "checked"]){
                    checked = prop;
                    break;
                }
            }
        }
        else{
            checked = false;
        }
    }
    
    return checked;
}

#define hanif_radio_create
var posX, posY, text, group, properties;
posX = argument[0];
posY = argument[1];
text = argument[2];
group = argument[3];
properties = ds_map_create();

if(is_undefined(hanifProjectUIControls)){
    show_debug_message("Hanif Project UI: Initialize failed!");
    return false;
}
else{
    if(is_undefined(posX) or is_undefined(posY) or is_undefined(text)){
        return -1;
    }
    else{
        ds_map_add(properties, "group", group);
        ds_map_add(properties, "x", posX);
        ds_map_add(properties, "y", posY);
        ds_map_add(properties, "text", text);
        ds_map_add(properties, "color", c_silver);
        ds_map_add(properties, "checked", true);
        ds_map_add(properties, "padding", 8);
        ds_map_add(properties, "size", 16);
        ds_map_add(properties, "clicked", false);
        ds_map_add(properties, "enable", true);
        ds_map_add(properties, "focus", false);
    
        if(ds_exists(group, ds_type_list)){
            ds_list_add(group, properties);
        }
        
        ds_list_add(hanifProjectUIControls, properties);
        
        return properties;
    }
}

#define hanif_radio_step
var handle, group, posX, posY, checked, color, padding, enable, focus, size, size;

handle = argument[0];

if(is_undefined(hanifProjectUIControls)){
    show_debug_message("Hanif Project UI: Initialize failed!");
    return false;
}
else{
    if(handle == -1){
        return false;
    }
    else{
        group = handle[? "group"];
        posX = handle[? "x"];
        posY = handle[? "y"];
        padding = handle[? "padding"];
        enable = handle[? "enable"];
        checked = handle[? "checked"];
        clicked = handle[? "clicked"];
        focus = handle[? "focus"];
        size = handle[? "size"];
        
        if(enable){
            var noActiveControl;
            noActiveControl = true;
            for(i=0;i<ds_list_size(hanifProjectUIControls);i++){
                if(ds_exists(hanifProjectUIControls[| i], ds_type_map)){
                    var existControl;
                    existControl = hanifProjectUIControls[| i];
                    if(existControl[? "open"]){
                        noActiveControl = false;
                        break;
                    }
                }
            }
            if(noActiveControl){
                if(keyboard_check_released(vk_enter) && focus){
                    if(!checked){
                        if(ds_exists(group, ds_type_list)){
                            for(i=0;i<ds_list_size(group);i++){
                                var prop = group[| i];
                                if(ds_exists(prop, ds_type_map) && prop != handle){
                                    if(ds_map_exists(prop, "checked")){
                                        ds_map_replace(prop, "checked", false);
                                        ds_map_replace(handle, "checked", !checked);
                                        if(checked){
                                            show_debug_message("Hanif Project UI:  control '" + string(handle) + "' is unchecked!");
                                        }
                                        else{
                                            show_debug_message("Hanif Project UI:  control '" + string(handle) + "' is checked!");
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                else{
                    if(device_mouse_x_to_gui(0) > posX && device_mouse_y_to_gui(0) > posY && device_mouse_x_to_gui(0) < posX + size + padding && device_mouse_y_to_gui(0) < posY + size + padding){
                        if(device_mouse_check_button_pressed(0, mb_left)){
                            ds_map_replace(handle, "clicked", true);
                        }
                        if(device_mouse_check_button_released(0, mb_left) && clicked){
                            ds_map_replace(handle, "clicked", false);
                            if(!focus){
                                ds_map_replace(handle, "focus", true);
                                show_debug_message("Hanif Project UI:  control '" + string(handle) + "' is focused now!");
                            }
                            if(!checked){
                                if(ds_exists(group, ds_type_list)){
                                    for(i=0;i<ds_list_size(group);i++){
                                        var prop = group[| i];
                                        if(ds_exists(prop, ds_type_map) && prop != handle){
                                            if(ds_map_exists(prop, "checked")){
                                                ds_map_replace(prop, "checked", false);
                                                ds_map_replace(handle, "checked", !checked);
                                                if(checked){
                                                    show_debug_message("Hanif Project UI:  control '" + string(handle) + "' is unchecked!");
                                                }
                                                else{
                                                    show_debug_message("Hanif Project UI:  control '" + string(handle) + "' is checked!");
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            var noActiveControl;
                            noActiveControl = true;
                            for(i=0;i<ds_list_size(hanifProjectUIControls);i++){
                                if(ds_exists(hanifProjectUIControls[| i], ds_type_map)){
                                    var existControl;
                                    existControl = hanifProjectUIControls[| i];
                                    if(existControl[? "open"]){
                                        noActiveControl = false;
                                        break;
                                    }
                                }
                            }
                            if(noActiveControl){
                                show_debug_message("Hanif Project UI:  control '" + string(handle) + "' clicked!");
                                return true;
                            }
                            else{
                                return false;
                            }
                        }
                    }
                    else{
                        ds_map_replace(handle, "clicked", false);
                        if(device_mouse_check_button_pressed(0, mb_left)){
                            if(focus){
                                ds_map_replace(handle, "focus", false);
                            }
                        }
                        return false;
                    }
                }
            }
            else{
                return false;
            }
        }
    }
}

#define hanif_radio_draw
var handle, posX, posY, text, checked, color, color0, color1, color2, padding, enable, focus, size, size;

handle = argument[0];

if(handle == -1){
    return false;
}
else{
    posX = handle[? "x"];
    posY = handle[? "y"];
    text = handle[? "text"];
    color = handle[? "color"];
    padding = handle[? "padding"];
    enable = handle[? "enable"];
    checked = handle[? "checked"];
    clicked = handle[? "clicked"];
    focus = handle[? "focus"];
    size = handle[? "size"];
    
    color0 = make_colour_hsv(colour_get_hue(color), colour_get_saturation(color), min(colour_get_value(color) + 25, 255));
    color1 = make_colour_hsv(colour_get_hue(color), colour_get_saturation(color), max(colour_get_value(color) - 50, 0));
    if(colour_get_value(color) > 128){
        color2 = c_black;
        color3 = c_white;
    }
    else{
        color2 = c_white;
        color3 = c_black;
    }
    
    if(enable){
        if(focus){
            draw_set_alpha(0.3);
            draw_roundrect_colour_ext(posX - 4, posY - 4, posX + size + padding + 4, posY + size + padding + 4, 16, 16, c_blue, c_blue, false);
            draw_set_alpha(0.4);
            draw_roundrect_colour_ext(posX - 3, posY - 3, posX + size + padding + 3, posY + size + padding + 3, 16, 16, c_white, c_white, false);
            draw_set_alpha(1);
        }
        else{
            draw_set_alpha(0.1);
            draw_roundrect_colour_ext(posX - 3, posY - 3, posX + size + padding + 3, posY + size + padding + 3, 16, 16, c_black, c_black, false);
            draw_set_alpha(1);
        }
        if(device_mouse_x_to_gui(0) > posX && device_mouse_y_to_gui(0) > posY && device_mouse_x_to_gui(0) < posX + size + padding && device_mouse_y_to_gui(0) < posY + size + padding){
            if(device_mouse_check_button(0, mb_left)){
                draw_roundrect_colour_ext(posX - 2, posY - 2, posX + size + padding, posY + size + padding, 16, 16, color1, color1, false);
                draw_roundrect_colour_ext(posX, posY, posX + size + padding + 2, posY + size + padding + 2, 16, 16, color0, color0, false);
                draw_roundrect_colour_ext(posX, posY, posX + size + padding, posY + size + padding, 16, 16, color, color, false);
                draw_set_alpha(0.3);
                draw_roundrect_colour_ext(posX, posY, posX + size + padding, posY + size + padding, 16, 16, c_black, c_black, false);
                draw_set_alpha(1);
            }
            else{
                draw_roundrect_colour_ext(posX - 2, posY - 2, posX + size + padding, posY + size + padding, 16, 16, color0, color0, false);
                draw_roundrect_colour_ext(posX, posY, posX + size + padding + 2, posY + size + padding + 2, 16, 16, color1, color1, false);
                draw_roundrect_colour_ext(posX, posY, posX + size + padding, posY + size + padding, 16, 16, color, color, false);
                draw_set_alpha(0.3);
                draw_roundrect_colour_ext(posX, posY, posX + size + padding, posY + size + padding, 16, 16, c_white, c_white, false);
                draw_set_alpha(1);
            }
        }
        else{
            draw_roundrect_colour_ext(posX - 2, posY - 2, posX + size + padding, posY + size + padding, 16, 16, color0, color0, false);
            draw_roundrect_colour_ext(posX, posY, posX + size + padding + 2, posY + size + padding + 2, 16, 16, color1, color1, false);
            draw_roundrect_colour_ext(posX, posY, posX + size + padding, posY + size + padding, 16, 16, color, color, false);
        }
        
        draw_set_alpha(0.25);
        draw_roundrect_colour_ext(posX + ((size + padding) / 2 - 10) + 2, posY + ((size + padding) / 2 - 10) + 2, posX + ((size + padding) / 2 - 10) + 20 - 2, posY + ((size + padding) / 2 - 10) + 20 - 2, 32, 32, color3, color3, false);
        draw_set_alpha(1);
        
        if(checked){            
            draw_circle_colour(posX + (size + padding) / 2 + 1, posY + (size + padding) / 2 + 2, 4, color3, color3, false);
            draw_circle_colour(posX + (size + padding) / 2, posY + (size + padding) / 2, 4, color2, color2, false);
        }
    }
    else{
        draw_roundrect_colour_ext(posX - 2, posY - 2, posX + size + padding + 2, posY + size + padding + 2, 16, 16, c_dkgray, c_dkgray, false);
        draw_roundrect_colour_ext(posX, posY, posX + size + padding, posY + size + padding, 16, 16, c_gray, c_gray, false);
        
        draw_set_alpha(0.25);
        draw_roundrect_colour_ext(posX + ((size + padding) / 2 - 10) + 2, posY + ((size + padding) / 2 - 10) + 2, posX + ((size + padding) / 2 - 10) + 20 - 2, posY + ((size + padding) / 2 - 10) + 20 - 2, 32, 32, c_dkgray, c_dkgray, false);
        draw_set_alpha(1);
        
        if(checked){
            draw_circle_colour(posX + (size + padding) / 2, posY + (size + padding) / 2, 4, c_silver, c_silver, false);
        }
    }
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_text_colour(posX + (size + padding) + 8, posY + (size + padding)/2, text, c_black, c_black, c_black, c_black, 1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

#define hanif_radio_set_checked
var handle, checked;

handle = argument[0];
checked = argument[1];

if(handle == -1){
    return false;
}
else{
    ds_map_replace(handle, "checked", checked);
    return true;
}

#define hanif_radio_set_size
var handle, size;

handle = argument[0];
size = argument[1];

if(handle == -1){
    return false;
}
else{
    ds_map_replace(handle, "size", size);
    return true;
}

#define hanif_radio_is_checked
var handle;

handle = argument[0];

if(handle == -1){
    return false;
}
else{
    return handle[? "checked"];
}

#define hanif_dropdown_create
var posX, posY, width, height, items, properties;
posX = argument[0];
posY = argument[1];
width = argument[2];
height = argument[3];
properties = ds_map_create();
items = ds_list_create();
itemSurface = surface_create(width, height);

if(is_undefined(hanifProjectUIControls)){
    show_debug_message("Hanif Project UI: Initialize failed!");
    return false;
}
else{
    if(is_undefined(posX) or is_undefined(posY) or is_undefined(width) or is_undefined(height)){
        return -1;
    }
    else{
        ds_map_add(properties, "x", posX);
        ds_map_add(properties, "y", posY);
        ds_map_add(properties, "width", width);
        ds_map_add(properties, "height", height);
        ds_map_add(properties, "itemHeight", 32);
        ds_map_add(properties, "maxHeight", 64);
        ds_map_add(properties, "open", false);
        ds_map_add(properties, "value", 0);
        ds_map_add(properties, "items", items);
        ds_map_add(properties, "color", c_silver);
        ds_map_add(properties, "padding", 8);
        ds_map_add(properties, "clicked", false);
        ds_map_add(properties, "enable", true);
        ds_map_add(properties, "focus", false);
        
        ds_list_add(hanifProjectUIControls, properties);
        
        return properties;
    }
}

#define hanif_dropdown_get_selected
var handle, checked;

handle = argument[0];
checked = -1;

if(handle == -1){
    return false;
}
else{
    var value, items;
    value = handle[? "value"];
    items = handle[? "items"];
    
    return items[| value];
}

#define hanif_dropdown_get_selected_text
var handle, checked;

handle = argument[0];
checked = -1;

if(handle == -1){
    return false;
}
else{
    var value, items, selected;
    value = handle[? "value"];
    items = handle[? "items"];
    
    selected = items[| value];
    
    return selected[? "text"];
}

#define hanif_dropdown_add_item
var handle, text, value, properties;
handle = argument[0];
text = argument[1];
properties = ds_map_create();

if(is_undefined(handle) or is_undefined(text)){
    return -1;
}
else{
    if(handle == -1){
        return false;
    }
    else{
        var items;
        items = handle[? "items"];
    
        if(ds_exists(items, ds_type_list)){        
            ds_map_add(properties, "handle", handle);
            ds_map_add(properties, "text", text);
            ds_map_add(properties, "color", c_silver);
            ds_map_add(properties, "padding", 8);
            ds_map_add(properties, "clicked", false);
            ds_map_add(properties, "enable", true);
            ds_map_add(properties, "focus", false);
            
            ds_list_add(items, properties);
            
            return properties;
        }
        else{
            return false;
        }
    }
}

#define hanif_dropdown_delete_item
var handle, item;
handle = argument[0];
item = argument[1];
properties = ds_map_create();

if(is_undefined(handle) or is_undefined(item)){
    return -1;
}
else{
    if(handle == -1){
        return false;
    }
    else{
        var items;
        items = handle[? "items"];
    
        if(ds_exists(items, ds_type_list)){        
            var pos;
            pos = ds_list_find_index(items, item);
            ds_list_delete(items, pos);
            
            return true;
        }
        else{
            return false;
        }
    }
}

#define hanif_dropdown_step
var handle, posX, posY, width, height, itemHeight, open, value, items, clicked, enable, focus;
handle = argument[0];

if(is_undefined(hanifProjectUIControls)){
    show_debug_message("Hanif Project UI: Initialize failed!");
    return false;
}
else{
    if(handle == -1){
        return false;
    }
    else{
        posX = handle[? "x"];
        posY = handle[? "y"];
        width = handle[? "width"];
        height = handle[? "height"];
        itemHeight = handle[? "itemHeight"];
        open = handle[? "open"];
        value = handle[? "value"];
        items = handle[? "items"];
        padding = handle[? "padding"];
        clicked = handle[? "clicked"];
        enable = handle[? "enable"];
        focus = handle[? "focus"];
        
        if(ds_exists(items, ds_type_list)){
            if(ds_list_size(items) > 0){
                selectedItem = items[| value];
                text = selectedItem[? "text"];
            }
            else{
                selectedItem = -1;
                text = "";
            }
        }
        else{
            selectedItem = -1;
            text = "";
        }
        
        if(enable){
            var noActiveControl;
            noActiveControl = true;
            for(i=0;i<ds_list_size(hanifProjectUIControls);i++){
                if(ds_exists(hanifProjectUIControls[| i], ds_type_map)){
                    var existControl;
                    existControl = hanifProjectUIControls[| i];
                    if(existControl != handle){
                        if(existControl[? "open"]){
                            noActiveControl = false;
                            break;
                        }
                    }
                }
            }
            if(noActiveControl){
                if(open){
                    if(device_mouse_check_button_released(0, mb_left)){
                        if(device_mouse_x_to_gui(0) > posX && device_mouse_y_to_gui(0) > posY + height + padding && device_mouse_x_to_gui(0) < posX + width + padding && device_mouse_y_to_gui(0) < posY + height + padding + (ds_list_size(items) * itemHeight)){
                             var index, curItem;
                             index = (device_mouse_y_to_gui(0) - (posY + height + padding)) div itemHeight;
                             curItem = items[| index];
                             if(ds_exists(curItem, ds_type_map)){
                                if(ds_map_exists(curItem, "enable")){
                                    if(curItem[? "enable"]){
                                         ds_map_replace(handle, "value", index);
                                         show_debug_message("Hanif Project UI:  control '" + string(handle) + "' is changed!");
                                        ds_map_replace(handle, "open", false);
                                    }
                                }
                             }
                         }
                         else{
                            ds_map_replace(handle, "open", false);
                         }
                    }
                }
                if(keyboard_check(vk_enter) && focus){
                    ds_map_replace(handle, "open", !open);
                    if(open){
                        show_debug_message("Hanif Project UI:  control '" + string(handle) + "' is closed!");
                    }
                    else{
                        show_debug_message("Hanif Project UI:  control '" + string(handle) + "' is opened!");
                    }
                    return true;
                }
                else{
                    if(device_mouse_x_to_gui(0) > posX && device_mouse_y_to_gui(0) > posY && device_mouse_x_to_gui(0) < posX + width + padding && device_mouse_y_to_gui(0) < posY + height + padding){
                        if(device_mouse_check_button_pressed(0, mb_left)){
                            ds_map_replace(handle, "clicked", true);
                        }
                        if(device_mouse_check_button_released(0, mb_left) && clicked){
                            ds_map_replace(handle, "clicked", false);
                            if(!focus){
                                ds_map_replace(handle, "focus", true);
                                show_debug_message("Hanif Project UI:  control '" + string(handle) + "' is focused now!");
                            }
                            ds_map_replace(handle, "open", !open);
                            if(open){
                                show_debug_message("Hanif Project UI:  control '" + string(handle) + "' is closed!");
                            }
                            else{
                                show_debug_message("Hanif Project UI:  control '" + string(handle) + "' is opened!");
                            }
                            return true;
                        }
                    }
                    else{
                        ds_map_replace(handle, "clicked", false);
                        if(device_mouse_check_button_pressed(0, mb_left)){
                            if(focus){
                                ds_map_replace(handle, "focus", false);
                            }
                        }
                        return false;
                    }
                }
            }
        }
    }
}

#define hanif_dropdown_draw
var handle, posX, posY, value, open, items, itemHeight, selectedItem, text, color, color0, color1, color2, padding, enable, focus, width, height;

handle = argument[0];

if(handle == -1){
    return false;
}
else{
    posX = handle[? "x"];
    posY = handle[? "y"];
    width = handle[? "width"];
    height = handle[? "height"];
    padding = handle[? "padding"];
    itemHeight = handle[? "itemHeight"];
    open = handle[? "open"];
    value = handle[? "value"];
    items = handle[? "items"];
    color = handle[? "color"];
    enable = handle[? "enable"];
    focus = handle[? "focus"];
    
    if(ds_exists(items, ds_type_list)){
        if(ds_list_size(items) > 0){
            selectedItem = items[| value];
            text = selectedItem[? "text"];
        }
        else{
            selectedItem = -1;
            text = "";
        }
    }
    else{
        selectedItem = -1;
        text = "";
    }
    
    color0 = make_colour_hsv(colour_get_hue(color), colour_get_saturation(color), min(colour_get_value(color) + 25, 255));
    color1 = make_colour_hsv(colour_get_hue(color), colour_get_saturation(color), max(colour_get_value(color) - 50, 0));
    if(colour_get_value(color) > 128){
        color2 = c_black;
        color3 = c_white;
    }
    else{
        color2 = c_white;
        color3 = c_black;
    }
    
    if(enable){
        if(focus){
            draw_set_alpha(0.3);
            draw_roundrect_colour_ext(posX - 4, posY - 4, posX + width + padding + 4, posY + height + padding + 4, 8, 8, c_blue, c_blue, false);
            draw_set_alpha(0.4);
            draw_roundrect_colour_ext(posX - 3, posY - 3, posX + width + padding + 3, posY + height + padding + 3, 8, 8, c_white, c_white, false);
            draw_set_alpha(1);
        }
        else{
            draw_set_alpha(0.1);
            draw_roundrect_colour_ext(posX - 3, posY - 3, posX + width + padding + 3, posY + height + padding + 3, 8, 8, c_black, c_black, false);
            draw_set_alpha(1);
        }
        
        if(open){
            for(i=0;i<ds_list_size(items);i++){
                var curItem, curColor0, curColor1, curEnable;
                curItem = items[| i];
                curEnable = curItem[? "enable"]
                curColor0 = make_colour_hsv(colour_get_hue(curItem[? "color"]), colour_get_saturation(curItem[? "color"]), min(colour_get_value(curItem[? "color"]) + 25, 255));
                curColor1 = make_colour_hsv(colour_get_hue(curItem[? "color"]), colour_get_saturation(curItem[? "color"]), max(colour_get_value(curItem[? "color"]) - 50, 0));
                if(curEnable){
                    draw_rectangle_colour(posX + 1, posY + height + padding + 2 + (i * itemHeight), posX - 2 + width + padding, posY + height + padding + 6 + itemHeight + (i * itemHeight), curColor0, curColor0, curColor0, curColor0, false);
                    draw_rectangle_colour(posX + 2, posY + height + padding + 3 + (i * itemHeight), posX - 1 + width + padding, posY + height + padding + 7 + itemHeight + (i * itemHeight), curColor1, curColor1, curColor1, curColor1, false);
                    draw_rectangle_colour(posX + 2, posY + height + padding + 3 + (i * itemHeight), posX - 2 + width + padding, posY + height + padding + 6 + itemHeight + (i * itemHeight), curItem[? "color"], curItem[? "color"], curItem[? "color"], curItem[? "color"], false);
                }
                else{
                    draw_rectangle_colour(posX + 1, posY + height + padding + 2 + (i * itemHeight), posX - 2 + width + padding, posY + height + padding + 6 + itemHeight + (i * itemHeight), curColor0, curColor0, curColor0, curColor0, false);
                    draw_rectangle_colour(posX + 2, posY + height + padding + 3 + (i * itemHeight), posX - 1 + width + padding, posY + height + padding + 7 + itemHeight + (i * itemHeight), curColor1, curColor1, curColor1, curColor1, false);
                    draw_rectangle_colour(posX + 2, posY + height + padding + 3 + (i * itemHeight), posX - 2 + width + padding, posY + height + padding + 6 + itemHeight + (i * itemHeight), c_silver, c_silver, c_silver, c_silver, false);
                }
                if(curEnable && device_mouse_x_to_gui(0) > posX && device_mouse_y_to_gui(0) > posY + height + padding + 3 + (i * itemHeight) && device_mouse_x_to_gui(0) < posX + width + padding && device_mouse_y_to_gui(0) < posY + height + padding + 6 + itemHeight + (i * itemHeight)){
                    draw_set_alpha(0.5);
                    if(device_mouse_check_button(0, mb_left)){
                        draw_rectangle_colour(posX + 2, posY + height + padding + 3 + (i * itemHeight), posX - 2 + width + padding, posY + height + padding + 6 + itemHeight + (i * itemHeight), c_black, c_black, c_black, c_black, false); 
                    }
                    else{
                        draw_rectangle_colour(posX + 2, posY + height + padding + 3 + (i * itemHeight), posX - 2 + width + padding, posY + height + padding + 6 + itemHeight + (i * itemHeight), c_white, c_white, c_white, c_white, false);
                    }
                    draw_set_alpha(1); 
                }
                
                draw_set_halign(fa_center);
                draw_set_valign(fa_middle);
                if(curEnable){
                    draw_text_colour(posX + (width + padding)/2, posY + height + padding + 3 + itemHeight/2  + (i * itemHeight), curItem[? "text"], c_dkgray, c_dkgray, c_dkgray, c_dkgray, 1);
                }
                else{
                    draw_text_colour(posX + (width + padding)/2, posY + height + padding + 3 + itemHeight/2  + (i * itemHeight), curItem[? "text"], c_gray, c_gray, c_gray, c_gray, 1);
                }
                draw_set_halign(fa_left);
                draw_set_valign(fa_top);
            }
        }
          
        if(device_mouse_x_to_gui(0) > posX && device_mouse_y_to_gui(0) > posY && device_mouse_x_to_gui(0) < posX + width + padding && device_mouse_y_to_gui(0) < posY + height + padding){
            if(device_mouse_check_button(0, mb_left)){
                draw_roundrect_colour_ext(posX - 2, posY - 2, posX + width + padding, posY + height + padding, 8, 8, color1, color1, false);
                draw_roundrect_colour_ext(posX, posY, posX + width + padding + 2, posY + height + padding + 2, 8, 8, color0, color0, false);
                draw_roundrect_colour_ext(posX, posY, posX + width + padding, posY + height + padding, 8, 8, color, color, false);
                draw_set_alpha(0.3);
                draw_roundrect_colour_ext(posX, posY, posX + width + padding, posY + height + padding, 8, 8, c_black, c_black, false);
                draw_set_alpha(1);
            }
            else{
                draw_roundrect_colour_ext(posX - 2, posY - 2, posX + width + padding, posY + height + padding, 8, 8, color0, color0, false);
                draw_roundrect_colour_ext(posX, posY, posX + width + padding + 2, posY + height + padding + 2, 8, 8, color1, color1, false);
                draw_roundrect_colour_ext(posX, posY, posX + width + padding, posY + height + padding, 8, 8, color, color, false);
                draw_set_alpha(0.3);
                draw_roundrect_colour_ext(posX, posY, posX + width + padding, posY + height + padding, 8, 8, c_white, c_white, false);
                draw_set_alpha(1);
            }
        }
        else{
            draw_roundrect_colour_ext(posX - 2, posY - 2, posX + width + padding, posY + height + padding, 8, 8, color0, color0, false);
            draw_roundrect_colour_ext(posX, posY, posX + width + padding + 2, posY + height + padding + 2, 8, 8, color1, color1, false);
            draw_roundrect_colour_ext(posX, posY, posX + width + padding, posY + height + padding, 8, 8, color, color, false);
        }
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text_colour(posX + (width + padding)/2 + 1, posY + (height + padding)/2 + 2, text, color3, color3, color3, color3, 0.3);
        draw_text_colour(posX + (width + padding)/2, posY + (height + padding)/2, text, color2, color2, color2, color2, 1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
    else{
        draw_roundrect_colour_ext(posX - 2, posY - 2, posX + width + padding + 2, posY + height + padding + 2, 8, 8, c_dkgray, c_dkgray, false);
        draw_roundrect_colour_ext(posX, posY, posX + width + padding, posY + height + padding, 8, 8, c_gray, c_gray, false);
            
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text_colour(posX + (width + padding)/2, posY + (height + padding)/2, text, c_silver, c_silver, c_silver, c_silver, 1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
}

