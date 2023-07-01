// JAVASCRIPT FOR THE SITE MASTER FILE
// Function to convert a hexadecimal color to RGB format
function hexToRgb(hex) {
    // Ensure hex is a string
    if (typeof hex !== 'string') {
        throw new TypeError('hexToRgb expects a string parameter');
    }

    // Remove the '#' symbol from the beginning
    hex = hex.replace('#', '');

    // Extract the red, green, and blue components
    const red = parseInt(hex.substring(0, 2), 16);
    const green = parseInt(hex.substring(2, 4), 16);
    const blue = parseInt(hex.substring(4, 6), 16);

    // Return the RGB color in "rgb(r, g, b)" format
    return `rgb(${red}, ${green}, ${blue})`;
}

// Function to calculate lightness from an RGB color value
function calculateLightness(color) {

    if (!color) {
        return; // or handle the case when color is null/undefined
    }

    const rgbComponents = color.match(/\d+/g);
    const red = parseInt(rgbComponents[0], 10);
    const green = parseInt(rgbComponents[1], 10);
    const blue = parseInt(rgbComponents[2], 10);

    const max = Math.max(red, green, blue);
    const min = Math.min(red, green, blue);

    const lightness = (max + min) / 2 / 255;

    return lightness;
}
// END OF JAVASCRIPT FOR THE SITE MASTER FILE

// CODE FOR THE ACCOUNT PAGE
const root = document.querySelector(':root');
//const primaryColorPicker = document.querySelector('#primary-color-picker');
//const backgroundColorPicker = document.querySelector('#background-color-picker');

if (primaryColorPicker) {
    primaryColorPicker.addEventListener('input', () => {
        setContrastRatio('--main-color', primaryColorPicker.value);
    });
}
else {
    //console.log('primaryColorPicker Not Found')
}

if (backgroundColorPicker) {
    backgroundColorPicker.addEventListener('input', () => {
        setContrastRatio('--background-color', backgroundColorPicker.value);
    });
}
else {
    //console.log('backgroundColorPicker Not Found')
}


function setContrastRatio(colorVariable, colorValue) {



    const luminanceOffset = 0.05;
    const correctedLuminance1 = getRelativeLuminance(backgroundColorPicker.value) + luminanceOffset;
    const correctedLuminance2 = getRelativeLuminance(primaryColorPicker.value) + luminanceOffset;

    const contrastRatio = Math.max(correctedLuminance1, correctedLuminance2) / Math.min(correctedLuminance1, correctedLuminance2);

    console.log(`Contrast ratio: ${contrastRatio}`);

    if (contrastRatio >= 2.1480) {
        console.log("Contrast ratio is good");
        root.style.setProperty(colorVariable, colorValue);
    }
}

function getRelativeLuminance(color) {
    const red = getComponentValue(color, 0) / 255;
    const green = getComponentValue(color, 1) / 255;
    const blue = getComponentValue(color, 2) / 255;

    const relativeLuminance = (0.2126 * red) + (0.7152 * green) + (0.0722 * blue);

    return relativeLuminance;
}

function getComponentValue(color, index) {
    const hexValue = color.substring(index * 2 + 1, index * 2 + 3);
    return parseInt(hexValue, 16);
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
        60 * (h < 0 ? h + 360 : h),
        100 * (s ? (l <= 0.5 ? s / (2 * l - s) : s / (2 - (2 * l - s))) : 0),
        (100 * (2 * l - s)) / 2,
    ];
}

// END OF CODE FOR THE ACCOUNT PAGE
