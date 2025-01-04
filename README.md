# MoErgo Glove80 Custom Configuration for ZMK

This configuration uses a [custom ZMK firmware](https://github.com/darknao/zmk/tree/darknao/rgb-layer-24.12) that includes per layer / per key RGB underglow, based on @valdur [mod](https://github.com/moergo-sc/zmk/compare/main...valdur:zmk-glove80:valdur-stuff).


## RGB Underglow Configuration

Add the following snippet to your keymap or in the "Custom Device-tree" field in the Glove80 Layout Editor:
```
/ {
    underglow-layer {
        compatible  = "zmk,underglow-layer";

        lower {
            bindings = <
    &ug ___    &ug ___  &ug ___    &ug ___    &ug ___                                                                                 &ug ___             &ug ___           &ug ___           &ug ___     &ug ___
    &ug PURPLE &ug PINK &ug PINK   &ug   PINK &ug   PINK &ug PINK                                                             &ug ___ &ug_nl WHITE ORANGE &ug ORANGE        &ug ORANGE        &ug ORANGE  &ug RED
    &ug PURPLE &ug ___  &ug ___    &ug ORANGE &ug ___    &ug ___                                                              &ug ___ &ug_nl RED YELLOW   &ug_nl RED YELLOW &ug_nl RED YELLOW &ug ORANGE  &ug ___
    &ug PURPLE &ug ___  &ug ORANGE &ug    RED &ug ORANGE &ug ___                                                              &ug ___ &ug_nl RED YELLOW   &ug_nl RED YELLOW &ug_nl RED YELLOW &ug ORANGE  &ug ___
    &ug   BLUE &ug ___  &ug RED    &ug    RED &ug    RED &ug ___  &ug_cl BLUE TEAL &ug ___   &ug ___  &ug ___ &ug ___ &ug ___ &ug ___ &ug_nl RED YELLOW   &ug_nl RED YELLOW &ug_nl RED YELLOW &ug    RED  &ug BLUE
    &ug ___    &ug ___  &ug ORANGE &ug ORANGE &ug ORANGE          &ug ___          &ug GREEN &ug ___  &ug ___ &ug ___ &ug ___         &ug_nl RED YELLOW   &ug_nl RED YELLOW &ug ORANGE        &ug    RED  &ug ___
                >;
            layer-id = <LAYER_Lower>;
        };
        another-layer {
            bindings = < [...] >;
            layer-id = <LAYER_Name>;
        };
    };
};
```
See the [keymap](config/glove80.keymap#L37) in this repository for a complete example.
This keymap is also available on the [Glove80 Layout Editor](https://my.glove80.com/#/layout/user/98218d07-c187-4a97-b020-f5df021abe73). 

__bindings__: This is a visual representation of the RGB underglow layer. `&ug COLOR` sets the underglow LED to the specified color. `___` means the RGB is off. You can use [predefined color name](https://github.com/darknao/zmk/blob/darknao/rgb-dts/app/include/dt-bindings/zmk/rgb_colors.h) or RGB hex code like `0xFF0000` for red.
`&ug_cl COLOR_OFF COLOR_ON` sets the underglow color according to the CAPSLOCK state. `&ug_nl` and `&ug_sl` do the same for NumLock & ScrollLock respectively.

__layer-id__: This must match the associated layer identifier. You can use the [automatically generated #define name](https://docs.moergo.com/layout-editor-guide/advanced-usage-custom-defined-behaviors/#reference-to-layers), like `LAYER_Base` or `LAYER_Lower`.

If you use your keyboard wirelessly, setting the underglow on your base layer will eat your battery like crazy.  
I recommend leaving `CONFIG_ZMK_RGB_UNDERGLOW_AUTO_OFF_IDLE` enabled in your [glove80.conf](config/glove80.conf) to turn off the underglow when the keyboard is idle and save some battery life.  

To get the HID indicators (NumLock/CapsLock/ScrollLock) working on the right side, you need to enable the `CONFIG_ZMK_SPLIT_PERIPHERAL_HID_INDICATORS` Kconfig.

## Build Instructions
1. Log into, or sign up for, your personal GitHub account.
2. Create your own repository using this repository as a template ([instructions](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template)) and check it out on your local computer.
3. If you use the official MoErgo configuration repository, make sure the [build configuration](.github/workflows/build.yml#L12) uses the correct repository/ref (`darknao/zmk` and `darknao/rgb-layer-24.12`).
4. Edit the keymap file(s) to suit your needs.
Alternatively, you can use the Glove80 Layout Editor to edit your layout, then copy the ZMK keymap in [your local repository](config/glove80.keymap).  
⚠️ **You can't build the firmware from the Layout Editor**. You must use GitHub Actions from this repository to build it.
5. Commit and push your changes to your personal repo. Upon pushing it, GitHub Actions will start building a new version of your firmware with the updated keymap.

## Firmware Files
To locate your firmware files and reflash your Glove80...
1. log into GitHub and navigate to your personal config repository you just uploaded your keymap changes to.
2. Click "Actions" in the main navigation, and in the left navigation click the "Build" link.
3. Select the desired workflow run in the centre area of the page (based on date and time of the build you wish to use). You can also start a new build from this page by clicking the "Run workflow" button.
4. After clicking the desired workflow run, you should be presented with a section at the bottom of the page called "Artifacts". This section contains the results of your build, in a file called "glove80.uf2"
5. Download the glove80.uf2
6. Flash the firmware to Glove80 according to the user documentation on the official Glove80 Glove80 Support website (linked above)

Your keyboard is now ready to use.

## Enabling RGB Underglow Layer Effect
Turn on the RGB underglow with the `RGB_TOG` key (Magic+T on the default layout).
Use the `RGB_EFF` key (Magic+G on the default layout) to cycle through all effects until the layer effect is enabled.
The layer effect is located after the swirl effect, and before the static color effect (the swirl effect will froze when the layer effect is enabled).

You can use the `RGB_BRI` and `RGB_BRD` to increase/decrease the underglow brightness.