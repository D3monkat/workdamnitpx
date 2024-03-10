module.exports = {
	content: ['./index.html', './src/**/*.{vue,js,ts,jsx,tsx}'],
	theme: {
		extend: {
			colors: {
				'ocean-blue': '#3BC3EA',
				'ocean-blue-light': '#BAE2ED',
				'ocean-blue-dark': '#2186A1',
				'ocean-blue-darker': '#185F71',
				'grey-dark': '#454442',
				'grey-light': '#A9A7A7',
				'grey-darker': '#272625',
				'white-dark': '#E6E6E6',
			},
			fontFamily: {
				PFDinDisplayPro: ['PFDinDisplayPro-Regular'],
				PFDinDisplayProBold: ['PFDinDisplayPro-Bold'],
			},
		},
	},
	plugins: [],
};
