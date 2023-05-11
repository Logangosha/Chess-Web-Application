
// CODE FOR THE ACCOUNT PAGE
const root = document.querySelector(':root');

// Set the --status-color variable to a lightened version of the primary color
var mainColor = getComputedStyle(root).getPropertyValue('--main-color');
root.style.setProperty('--status-color', 'hsl(' + RGBToHSL(mainColor)[0] + ',100%,20%)');

if (primaryColorPicker != null) {
    primaryColorPicker.addEventListener('input', () => {
        getContrastRatio('--main-color');
    });
}

if (backgroundColorPicker != null) {
    backgroundColorPicker.addEventListener('input', () => {
        getContrastRatio('--background-color');
    });
}

function getContrastRatio(name) {
    // Get the relative luminance of each color

    

    const luminance1 = getRelativeLuminance(primaryColorPicker.value);
    const luminance2 = getRelativeLuminance(backgroundColorPicker.value);
    const luminanceOffset = 0.05;
    const correctedLuminance1 = luminance1 + luminanceOffset;
    const correctedLuminance2 = luminance2 + luminanceOffset;

    // Calculate the contrast ratio
    const contrastRatio = Math.max(correctedLuminance1, correctedLuminance2) / Math.min(correctedLuminance1, correctedLuminance2);

    // Display the contrast ratio on the console
    console.log(`Contrast ratio: ${contrastRatio}`);


    if (contrastRatio >= 2.1480) {
        console.log("Contrast ratio is good");
        if (name === "--main-color") {
            console.log('primary');
            root.style.setProperty(name, primaryColorPicker.value);
            root.style.setProperty('--status-color', 'hsl(' + RGBToHSL(primaryColorPicker.value)[0] + ',100%,20%)');
        } else {
            console.log("background");
            root.style.setProperty(name, backgroundColorPicker.value);
        }
    }
}

function getRelativeLuminance(color) {
    // Get the red, green, and blue values of the color
    const red = getComponentValue(color, 0) / 255;
    console.log(`red: ${red}`);
    const green = getComponentValue(color, 1) / 255;
    console.log(`green: ${green}`);
    const blue = getComponentValue(color, 2) / 255;
    console.log(`blue: ${blue}`);

    // Calculate the relative luminance of the color
    const relativeLuminance = (0.2126 * red) + (0.7152 * green) + (0.0722 * blue);
    console.log(`relativeLuminance: ${relativeLuminance}`);

    return relativeLuminance;
}

function getComponentValue(color, index) {
    // Extract the component value from the color string
    const hexValue = color.substring(index * 2 + 1, index * 2 + 3);

    // Convert the hex value to a decimal value
    const decimalValue = parseInt(hexValue, 16);

    // Return the decimal value
    return decimalValue;
}

function RGBToHSL(hex) {
    const r = parseInt(hex.slice(1, 3), 16) / 255;
    const g = parseInt(hex.slice(3, 5), 16) / 255;
    const b = parseInt(hex.slice(5, 7), 16) / 255;
    const l = Math.max(r, g, b);
    const s = l - Math.min(r, g, b);
    const h = s
        ? l === r
            ? (g - b) / s
            : l === g
                ? 2 + (b - r) / s
                : 4 + (r - g) / s
        : 0;
    return [
        60 * h < 0 ? 60 * h + 360 : 60 * h,
        100 * (s ? (l <= 0.5 ? s / (2 * l - s) : s / (2 - (2 * l - s))) : 0),
        (100 * (2 * l - s)) / 2,
    ];
};

// END OF CODE FOR THE ACCOUNT PAGE
