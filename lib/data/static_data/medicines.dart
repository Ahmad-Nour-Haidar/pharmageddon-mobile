import 'dart:math';

final medicines = {
  "status": 200,
  "data": {
    "medicines": [
      {
        "id": 1,
        "english_scientific_name": "Unadol blue",
        "arabic_scientific_name": "بندول أزرق",
        "english_commercial_name": "Paracetamol",
        "arabic_commercial_name": "باراسيتامول",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 10,
        "price_after_discount": 4500,
        "is_favourite": false,
        "arabic_description": "كل مضغوطة تحتوي على: 500 ملغ باراسيتامول.",
        "english_description":
            "Each film coated tablets contains: 500 mg Paracetamol.",
        "image_name": "m1.jpg",
        "expiration_date": "2024-03-27T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 2,
          "arabic_name": "يونفارما",
          "english_name": "Unipharma"
        },
        "effect_category": {
          "id": 1,
          "arabic_name": "مسكن آلام",
          "english_name": "Analgesics",
          "image_name": "e1.jpg"
        }
      },
      {
        "id": 2,
        "english_scientific_name": "Unadol red",
        "arabic_scientific_name": "بندول أحمر",
        "english_commercial_name": "Paracetamol",
        "arabic_commercial_name": "باراسيتامول",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description":
            "يحتوي كل قرص مغلف على: 500 ملغ باراسيتامول و 65 ملغ كافيين.",
        "english_description":
            "Each film coated tablet contains: 500mg  Paracetamol & 65 mg Caffeine..",
        "image_name": "m2.jpg",
        "expiration_date": "2024-01-09T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 2,
          "arabic_name": "يونفارما",
          "english_name": "Unipharma"
        },
        "effect_category": {
          "id": 1,
          "arabic_name": "مسكن آلام",
          "english_name": "Analgesics",
          "image_name": "e1.jpg"
        }
      },
      {
        "id": 3,
        "english_scientific_name": "Unadol yellow",
        "arabic_scientific_name": "بندول أصفر",
        "english_commercial_name": "Paracetamol",
        "arabic_commercial_name": "باراسيتامول",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description":
            "يحتوي كل قرص مغلف على: 500 ملغ باراسيتامول، كافيين 25 ملغ، فينيليفرين هيدروكلورايد 5 ملغ.",
        "english_description":
            "Each film coated tablets contains: 500 mg Paracetamol, Caffeine 25 mg, Phenylephrine Hydrocloride 5 mg.",
        "image_name": "m3.jpg",
        "expiration_date": "2024-01-21T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 2,
          "arabic_name": "يونفارما",
          "english_name": "Unipharma"
        },
        "effect_category": {
          "id": 1,
          "arabic_name": "مسكن آلام",
          "english_name": "Analgesics",
          "image_name": "e1.jpg"
        }
      },
      {
        "id": 4,
        "english_scientific_name": "Clarityn",
        "arabic_scientific_name": "كلاريتين",
        "english_commercial_name": "Loratadine",
        "arabic_commercial_name": "لوراتيدين",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description": "يحتوي كل قرص على: 10 ملغ من لوراتادين.",
        "english_description": "Each tablet contains: 10 mg loratadine.",
        "image_name": "m4.jpg",
        "expiration_date": "2024-01-19T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 2,
          "arabic_name": "يونفارما",
          "english_name": "Unipharma"
        },
        "effect_category": {
          "id": 4,
          "arabic_name": "مضاد هسيتامين",
          "english_name": "Anti-histamine",
          "image_name": "e4.jpg"
        }
      },
      {
        "id": 5,
        "english_scientific_name": "SelSun",
        "arabic_scientific_name": "سيلسن",
        "english_commercial_name": "Selenium Sulphide Lotion",
        "arabic_commercial_name": "غسول كبريتيد السيلينيوم",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description":
            "غسول كبريتيد السيلينيوم هو مستحضر سائل مضاد للدهون ومضاد للفطريات يحتوي على كبريتيد السيلينيوم 2.5% وزن/حجم في محلول مائي، وهو مخصص للاستخدام الموضعي.",
        "english_description":
            "SELSEN (Selenium Sulfide Lotion) is a liquid antiseborrheic, antifungal preparation containing selenium sulfide 2,5% w/v in an aqueous suspension, and is intended for topical application.",
        "image_name": "m5.jpg",
        "expiration_date": "2024-02-05T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 2,
          "arabic_name": "يونفارما",
          "english_name": "Unipharma"
        },
        "effect_category": {
          "id": 6,
          "arabic_name": "مضاد قشرة",
          "english_name": "Anti-dandruff",
          "image_name": "e6.jpg"
        }
      },
      {
        "id": 6,
        "english_scientific_name": "Calcium",
        "arabic_scientific_name": "كالسيوم",
        "english_commercial_name": "Calcium carbonate",
        "arabic_commercial_name": "كربونات الكاسيوم",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 30,
        "price_after_discount": 3500,
        "is_favourite": false,
        "arabic_description":
            "كل مضغوطة تحتوي على 200 وحدة دولية من الكالسيوم.",
        "english_description": "Each tablet contains 200 IU of calcium.",
        "image_name": "m6.jpg",
        "expiration_date": "2024-02-29T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 1,
          "arabic_name": "ابن الهيثم",
          "english_name": "Ebn Alhaytham"
        },
        "effect_category": {
          "id": 5,
          "arabic_name": "مكمل غذائي",
          "english_name": "Dietary Supplement",
          "image_name": "e5.jpg"
        }
      },
      {
        "id": 7,
        "english_scientific_name": "Augmatex",
        "arabic_scientific_name": "أوغماتيكس",
        "english_commercial_name": "Amoxicillin",
        "arabic_commercial_name": "أموكسيسيللين",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description":
            "(أموكسيسيللين 875 ملغ + كلافولانيك أسيد 125 ملغ) / 14 مضغوطة.",
        "english_description":
            "(Amoxicillin 875 mg + clavulanic acid 125 mg) / 14 tablets",
        "image_name": "m7.jpg",
        "expiration_date": "2024-02-01T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 4,
          "arabic_name": "ابن زهر",
          "english_name": "Ebn Zaher"
        },
        "effect_category": {
          "id": 2,
          "arabic_name": "مضاد حيوي",
          "english_name": "Anti-inflammatory",
          "image_name": "e2.jpg"
        }
      },
      {
        "id": 8,
        "english_scientific_name": "Maxiflux",
        "arabic_scientific_name": "ماكسيفلكس",
        "english_commercial_name": "Amoxicillin",
        "arabic_commercial_name": "أموكسيسيللين",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 10,
        "price_after_discount": 4500,
        "is_favourite": false,
        "arabic_description":
            "أموكسيسيلين 125 ملغ + فلوكلوكساسيللين 125 ملغ / ٢٠ كبسولة.",
        "english_description":
            "Amoxicillin 125 mg + Flucloxacillin 125 mg / 20 capsules.",
        "image_name": "m8.jpg",
        "expiration_date": "2024-03-18T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 4,
          "arabic_name": "ابن زهر",
          "english_name": "Ebn Zaher"
        },
        "effect_category": {
          "id": 2,
          "arabic_name": "مضاد حيوي",
          "english_name": "Anti-inflammatory",
          "image_name": "e2.jpg"
        }
      },
      {
        "id": 9,
        "english_scientific_name": "Indapamide S.R.Biomed",
        "arabic_scientific_name": "إنداباميد",
        "english_commercial_name": "Indapamide",
        "arabic_commercial_name": "إنداباميد",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description":
            "كل مضغوطة إنداباميد 1.5 تحتوي على 1.5 ملغ إنداباميد.",
        "english_description":
            "Each Indapamide 1.5 tablet contains 1.5 mg Indapamide.",
        "image_name": "m9.jpg",
        "expiration_date": "2024-01-30T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 3,
          "arabic_name": "بيوميد فارما",
          "english_name": "Biomed Pharma"
        },
        "effect_category": {
          "id": 3,
          "arabic_name": "منظم ضغط",
          "english_name": "Blood Pressure Regulator",
          "image_name": "e3.jpg"
        }
      },
      {
        "id": 10,
        "english_scientific_name": "Telmedibine",
        "arabic_scientific_name": "تيلميدبين",
        "english_commercial_name": "Telmisartan/amlodipine",
        "arabic_commercial_name": "تيلميسارتان / أملوديبين",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description": "تحتوي كل مضغوطة 40 ملغ على 5 ملغ أملوديبين.",
        "english_description": "Each 40 mg tablet contains 5 mg amlodipine.",
        "image_name": "m10.jpg",
        "expiration_date": "2024-01-31T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 3,
          "arabic_name": "بيوميد فارما",
          "english_name": "Biomed Pharma"
        },
        "effect_category": {
          "id": 3,
          "arabic_name": "منظم ضغط",
          "english_name": "Blood Pressure Regulator",
          "image_name": "e3.jpg"
        }
      },
      {
        "id": 11,
        "english_scientific_name": "Zinc Ugarit",
        "arabic_scientific_name": "زنك أوغاريت",
        "english_commercial_name": "Zinc",
        "arabic_commercial_name": "زنك",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 10,
        "price_after_discount": 4500,
        "is_favourite": false,
        "arabic_description": "تحتوي كل مضغوطة على 50 ملغ زنك.",
        "english_description": "Each tablet contains 50 mg zinc.",
        "image_name": "m11.jpg",
        "expiration_date": "2024-03-30T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 5,
          "arabic_name": "أوغاريت",
          "english_name": "Ugarit"
        },
        "effect_category": {
          "id": 5,
          "arabic_name": "مكمل غذائي",
          "english_name": "Dietary Supplement",
          "image_name": "e5.jpg"
        }
      },
      {
        "id": 12,
        "english_scientific_name": "Omega3",
        "arabic_scientific_name": "أوميغا3",
        "english_commercial_name": "Omega3",
        "arabic_commercial_name": "أوميغا3",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description":
            "تحتوي كل كبسولة من مستحضر  أوميغا-3 فورت على 500 مغ من خلاصة الطحالب البحرية الفائقة النعومة الحاوية على الحموض الدسمة التالية : حمض ايكوسابنتانوئيك (EPA) / حمض ديكوساهيكسانوئيك / حمض النخيل / حمض جوزة الطيب.",
        "english_description":
            "Each capsule of Omega-3 Forte contains 500 mg of ultra-fine marine algae extract containing the following fatty acids: eicosapentaenoic acid (EPA) / dicosahexaenoic acid / palmitic acid / nutmeg acid.",
        "image_name": "m12.jpg",
        "expiration_date": "2023-12-24T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 5,
          "arabic_name": "أوغاريت",
          "english_name": "Ugarit"
        },
        "effect_category": {
          "id": 5,
          "arabic_name": "مكمل غذائي",
          "english_name": "Dietary Supplement",
          "image_name": "e5.jpg"
        }
      },
      {
        "id": 13,
        "english_scientific_name": "Ginseng B Complex",
        "arabic_scientific_name": "جينسنغ ب كومبلكس",
        "english_commercial_name": "B Complex",
        "arabic_commercial_name": "ب كومبلكس",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 10,
        "price_after_discount": 4500,
        "is_favourite": false,
        "arabic_description": "يحتوي على فيتامينات ب1 ب2 ب5 ب6 ب12.",
        "english_description":
            "It contains vitamins : B1, B2, B5, B6, and B12.",
        "image_name": "m13.jpg",
        "expiration_date": "2024-03-15T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 5,
          "arabic_name": "أوغاريت",
          "english_name": "Ugarit"
        },
        "effect_category": {
          "id": 5,
          "arabic_name": "مكمل غذائي",
          "english_name": "Dietary Supplement",
          "image_name": "e5.jpg"
        }
      },
      {
        "id": 14,
        "english_scientific_name": "Unadol blue",
        "arabic_scientific_name": "بندول أزرق",
        "english_commercial_name": "Paracetamol",
        "arabic_commercial_name": "باراسيتامول",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description": "كل مضغوطة تحتوي على: 500 ملغ باراسيتامول.",
        "english_description":
            "Each film coated tablets contains: 500 mg Paracetamol.",
        "image_name": "m1.jpg",
        "expiration_date": "2024-02-01T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 2,
          "arabic_name": "يونفارما",
          "english_name": "Unipharma"
        },
        "effect_category": {
          "id": 1,
          "arabic_name": "مسكن آلام",
          "english_name": "Analgesics",
          "image_name": "e1.jpg"
        }
      },
      {
        "id": 15,
        "english_scientific_name": "Unadol red",
        "arabic_scientific_name": "بندول أحمر",
        "english_commercial_name": "Paracetamol",
        "arabic_commercial_name": "باراسيتامول",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 30,
        "price_after_discount": 3500,
        "is_favourite": false,
        "arabic_description":
            "يحتوي كل قرص مغلف على: 500 ملغ باراسيتامول و 65 ملغ كافيين.",
        "english_description":
            "Each film coated tablet contains: 500mg  Paracetamol & 65 mg Caffeine..",
        "image_name": "m2.jpg",
        "expiration_date": "2024-02-24T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 2,
          "arabic_name": "يونفارما",
          "english_name": "Unipharma"
        },
        "effect_category": {
          "id": 1,
          "arabic_name": "مسكن آلام",
          "english_name": "Analgesics",
          "image_name": "e1.jpg"
        }
      },
      {
        "id": 16,
        "english_scientific_name": "Unadol yellow",
        "arabic_scientific_name": "بندول أصفر",
        "english_commercial_name": "Paracetamol",
        "arabic_commercial_name": "باراسيتامول",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description":
            "يحتوي كل قرص مغلف على: 500 ملغ باراسيتامول، كافيين 25 ملغ، فينيليفرين هيدروكلورايد 5 ملغ.",
        "english_description":
            "Each film coated tablets contains: 500 mg Paracetamol, Caffeine 25 mg, Phenylephrine Hydrocloride 5 mg.",
        "image_name": "m3.jpg",
        "expiration_date": "2023-12-19T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 2,
          "arabic_name": "يونفارما",
          "english_name": "Unipharma"
        },
        "effect_category": {
          "id": 1,
          "arabic_name": "مسكن آلام",
          "english_name": "Analgesics",
          "image_name": "e1.jpg"
        }
      },
      {
        "id": 17,
        "english_scientific_name": "Clarityn",
        "arabic_scientific_name": "كلاريتين",
        "english_commercial_name": "Loratadine",
        "arabic_commercial_name": "لوراتيدين",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 10,
        "price_after_discount": 4500,
        "is_favourite": false,
        "arabic_description": "يحتوي كل قرص على: 10 ملغ من لوراتادين.",
        "english_description": "Each tablet contains: 10 mg loratadine.",
        "image_name": "m4.jpg",
        "expiration_date": "2024-03-17T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 2,
          "arabic_name": "يونفارما",
          "english_name": "Unipharma"
        },
        "effect_category": {
          "id": 4,
          "arabic_name": "مضاد هسيتامين",
          "english_name": "Anti-histamine",
          "image_name": "e4.jpg"
        }
      },
      {
        "id": 18,
        "english_scientific_name": "SelSun",
        "arabic_scientific_name": "سيلسن",
        "english_commercial_name": "Selenium Sulphide Lotion",
        "arabic_commercial_name": "غسول كبريتيد السيلينيوم",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description":
            "غسول كبريتيد السيلينيوم هو مستحضر سائل مضاد للدهون ومضاد للفطريات يحتوي على كبريتيد السيلينيوم 2.5% وزن/حجم في محلول مائي، وهو مخصص للاستخدام الموضعي.",
        "english_description":
            "SELSEN (Selenium Sulfide Lotion) is a liquid antiseborrheic, antifungal preparation containing selenium sulfide 2,5% w/v in an aqueous suspension, and is intended for topical application.",
        "image_name": "m5.jpg",
        "expiration_date": "2024-01-09T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 2,
          "arabic_name": "يونفارما",
          "english_name": "Unipharma"
        },
        "effect_category": {
          "id": 6,
          "arabic_name": "مضاد قشرة",
          "english_name": "Anti-dandruff",
          "image_name": "e6.jpg"
        }
      },
      {
        "id": 19,
        "english_scientific_name": "Calcium",
        "arabic_scientific_name": "كالسيوم",
        "english_commercial_name": "Calcium carbonate",
        "arabic_commercial_name": "كربونات الكاسيوم",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 10,
        "price_after_discount": 4500,
        "is_favourite": false,
        "arabic_description":
            "كل مضغوطة تحتوي على 200 وحدة دولية من الكالسيوم.",
        "english_description": "Each tablet contains 200 IU of calcium.",
        "image_name": "m6.jpg",
        "expiration_date": "2024-03-16T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 1,
          "arabic_name": "ابن الهيثم",
          "english_name": "Ebn Alhaytham"
        },
        "effect_category": {
          "id": 5,
          "arabic_name": "مكمل غذائي",
          "english_name": "Dietary Supplement",
          "image_name": "e5.jpg"
        }
      },
      {
        "id": 20,
        "english_scientific_name": "Augmatex",
        "arabic_scientific_name": "أوغماتيكس",
        "english_commercial_name": "Amoxicillin",
        "arabic_commercial_name": "أموكسيسيللين",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description":
            "(أموكسيسيللين 875 ملغ + كلافولانيك أسيد 125 ملغ) / 14 مضغوطة.",
        "english_description":
            "(Amoxicillin 875 mg + clavulanic acid 125 mg) / 14 tablets",
        "image_name": "m7.jpg",
        "expiration_date": "2023-12-22T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 4,
          "arabic_name": "ابن زهر",
          "english_name": "Ebn Zaher"
        },
        "effect_category": {
          "id": 2,
          "arabic_name": "مضاد حيوي",
          "english_name": "Anti-inflammatory",
          "image_name": "e2.jpg"
        }
      },
      {
        "id": 21,
        "english_scientific_name": "Maxiflux",
        "arabic_scientific_name": "ماكسيفلكس",
        "english_commercial_name": "Amoxicillin",
        "arabic_commercial_name": "أموكسيسيللين",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description":
            "أموكسيسيلين 125 ملغ + فلوكلوكساسيللين 125 ملغ / ٢٠ كبسولة.",
        "english_description":
            "Amoxicillin 125 mg + Flucloxacillin 125 mg / 20 capsules.",
        "image_name": "m8.jpg",
        "expiration_date": "2024-01-25T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 4,
          "arabic_name": "ابن زهر",
          "english_name": "Ebn Zaher"
        },
        "effect_category": {
          "id": 2,
          "arabic_name": "مضاد حيوي",
          "english_name": "Anti-inflammatory",
          "image_name": "e2.jpg"
        }
      },
      {
        "id": 22,
        "english_scientific_name": "Indapamide S.R.Biomed",
        "arabic_scientific_name": "إنداباميد",
        "english_commercial_name": "Indapamide",
        "arabic_commercial_name": "إنداباميد",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description":
            "كل مضغوطة إنداباميد 1.5 تحتوي على 1.5 ملغ إنداباميد.",
        "english_description":
            "Each Indapamide 1.5 tablet contains 1.5 mg Indapamide.",
        "image_name": "m9.jpg",
        "expiration_date": "2023-12-08T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 3,
          "arabic_name": "بيوميد فارما",
          "english_name": "Biomed Pharma"
        },
        "effect_category": {
          "id": 3,
          "arabic_name": "منظم ضغط",
          "english_name": "Blood Pressure Regulator",
          "image_name": "e3.jpg"
        }
      },
      {
        "id": 23,
        "english_scientific_name": "Telmedibine",
        "arabic_scientific_name": "تيلميدبين",
        "english_commercial_name": "Telmisartan/amlodipine",
        "arabic_commercial_name": "تيلميسارتان / أملوديبين",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 30,
        "price_after_discount": 3500,
        "is_favourite": false,
        "arabic_description": "تحتوي كل مضغوطة 40 ملغ على 5 ملغ أملوديبين.",
        "english_description": "Each 40 mg tablet contains 5 mg amlodipine.",
        "image_name": "m10.jpg",
        "expiration_date": "2024-02-18T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 3,
          "arabic_name": "بيوميد فارما",
          "english_name": "Biomed Pharma"
        },
        "effect_category": {
          "id": 3,
          "arabic_name": "منظم ضغط",
          "english_name": "Blood Pressure Regulator",
          "image_name": "e3.jpg"
        }
      },
      {
        "id": 24,
        "english_scientific_name": "Zinc Ugarit",
        "arabic_scientific_name": "زنك أوغاريت",
        "english_commercial_name": "Zinc",
        "arabic_commercial_name": "زنك",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description": "تحتوي كل مضغوطة على 50 ملغ زنك.",
        "english_description": "Each tablet contains 50 mg zinc.",
        "image_name": "m11.jpg",
        "expiration_date": "2024-01-06T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 5,
          "arabic_name": "أوغاريت",
          "english_name": "Ugarit"
        },
        "effect_category": {
          "id": 5,
          "arabic_name": "مكمل غذائي",
          "english_name": "Dietary Supplement",
          "image_name": "e5.jpg"
        }
      },
      {
        "id": 25,
        "english_scientific_name": "Omega3",
        "arabic_scientific_name": "أوميغا3",
        "english_commercial_name": "Omega3",
        "arabic_commercial_name": "أوميغا3",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 10,
        "price_after_discount": 4500,
        "is_favourite": false,
        "arabic_description":
            "تحتوي كل كبسولة من مستحضر  أوميغا-3 فورت على 500 مغ من خلاصة الطحالب البحرية الفائقة النعومة الحاوية على الحموض الدسمة التالية : حمض ايكوسابنتانوئيك (EPA) / حمض ديكوساهيكسانوئيك / حمض النخيل / حمض جوزة الطيب.",
        "english_description":
            "Each capsule of Omega-3 Forte contains 500 mg of ultra-fine marine algae extract containing the following fatty acids: eicosapentaenoic acid (EPA) / dicosahexaenoic acid / palmitic acid / nutmeg acid.",
        "image_name": "m12.jpg",
        "expiration_date": "2024-03-14T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 5,
          "arabic_name": "أوغاريت",
          "english_name": "Ugarit"
        },
        "effect_category": {
          "id": 5,
          "arabic_name": "مكمل غذائي",
          "english_name": "Dietary Supplement",
          "image_name": "e5.jpg"
        }
      },
      {
        "id": 26,
        "english_scientific_name": "Ginseng B Complex",
        "arabic_scientific_name": "جينسنغ ب كومبلكس",
        "english_commercial_name": "B Complex",
        "arabic_commercial_name": "ب كومبلكس",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description": "يحتوي على فيتامينات ب1 ب2 ب5 ب6 ب12.",
        "english_description":
            "It contains vitamins : B1, B2, B5, B6, and B12.",
        "image_name": "m13.jpg",
        "expiration_date": "2023-12-25T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 5,
          "arabic_name": "أوغاريت",
          "english_name": "Ugarit"
        },
        "effect_category": {
          "id": 5,
          "arabic_name": "مكمل غذائي",
          "english_name": "Dietary Supplement",
          "image_name": "e5.jpg"
        }
      },
      {
        "id": 27,
        "english_scientific_name": "Unadol blue",
        "arabic_scientific_name": "بندول أزرق",
        "english_commercial_name": "Paracetamol",
        "arabic_commercial_name": "باراسيتامول",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description": "كل مضغوطة تحتوي على: 500 ملغ باراسيتامول.",
        "english_description":
            "Each film coated tablets contains: 500 mg Paracetamol.",
        "image_name": "m1.jpg",
        "expiration_date": "2024-01-08T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 2,
          "arabic_name": "يونفارما",
          "english_name": "Unipharma"
        },
        "effect_category": {
          "id": 1,
          "arabic_name": "مسكن آلام",
          "english_name": "Analgesics",
          "image_name": "e1.jpg"
        }
      },
      {
        "id": 28,
        "english_scientific_name": "Unadol red",
        "arabic_scientific_name": "بندول أحمر",
        "english_commercial_name": "Paracetamol",
        "arabic_commercial_name": "باراسيتامول",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description":
            "يحتوي كل قرص مغلف على: 500 ملغ باراسيتامول و 65 ملغ كافيين.",
        "english_description":
            "Each film coated tablet contains: 500mg  Paracetamol & 65 mg Caffeine..",
        "image_name": "m2.jpg",
        "expiration_date": "2023-12-28T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 2,
          "arabic_name": "يونفارما",
          "english_name": "Unipharma"
        },
        "effect_category": {
          "id": 1,
          "arabic_name": "مسكن آلام",
          "english_name": "Analgesics",
          "image_name": "e1.jpg"
        }
      },
      {
        "id": 29,
        "english_scientific_name": "Unadol yellow",
        "arabic_scientific_name": "بندول أصفر",
        "english_commercial_name": "Paracetamol",
        "arabic_commercial_name": "باراسيتامول",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 30,
        "price_after_discount": 3500,
        "is_favourite": false,
        "arabic_description":
            "يحتوي كل قرص مغلف على: 500 ملغ باراسيتامول، كافيين 25 ملغ، فينيليفرين هيدروكلورايد 5 ملغ.",
        "english_description":
            "Each film coated tablets contains: 500 mg Paracetamol, Caffeine 25 mg, Phenylephrine Hydrocloride 5 mg.",
        "image_name": "m3.jpg",
        "expiration_date": "2024-02-22T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 2,
          "arabic_name": "يونفارما",
          "english_name": "Unipharma"
        },
        "effect_category": {
          "id": 1,
          "arabic_name": "مسكن آلام",
          "english_name": "Analgesics",
          "image_name": "e1.jpg"
        }
      },
      {
        "id": 30,
        "english_scientific_name": "Clarityn",
        "arabic_scientific_name": "كلاريتين",
        "english_commercial_name": "Loratadine",
        "arabic_commercial_name": "لوراتيدين",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description": "يحتوي كل قرص على: 10 ملغ من لوراتادين.",
        "english_description": "Each tablet contains: 10 mg loratadine.",
        "image_name": "m4.jpg",
        "expiration_date": "2024-02-04T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 2,
          "arabic_name": "يونفارما",
          "english_name": "Unipharma"
        },
        "effect_category": {
          "id": 4,
          "arabic_name": "مضاد هسيتامين",
          "english_name": "Anti-histamine",
          "image_name": "e4.jpg"
        }
      },
      {
        "id": 31,
        "english_scientific_name": "SelSun",
        "arabic_scientific_name": "سيلسن",
        "english_commercial_name": "Selenium Sulphide Lotion",
        "arabic_commercial_name": "غسول كبريتيد السيلينيوم",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 10,
        "price_after_discount": 4500,
        "is_favourite": false,
        "arabic_description":
            "غسول كبريتيد السيلينيوم هو مستحضر سائل مضاد للدهون ومضاد للفطريات يحتوي على كبريتيد السيلينيوم 2.5% وزن/حجم في محلول مائي، وهو مخصص للاستخدام الموضعي.",
        "english_description":
            "SELSEN (Selenium Sulfide Lotion) is a liquid antiseborrheic, antifungal preparation containing selenium sulfide 2,5% w/v in an aqueous suspension, and is intended for topical application.",
        "image_name": "m5.jpg",
        "expiration_date": "2024-03-22T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 2,
          "arabic_name": "يونفارما",
          "english_name": "Unipharma"
        },
        "effect_category": {
          "id": 6,
          "arabic_name": "مضاد قشرة",
          "english_name": "Anti-dandruff",
          "image_name": "e6.jpg"
        }
      },
      {
        "id": 32,
        "english_scientific_name": "Calcium",
        "arabic_scientific_name": "كالسيوم",
        "english_commercial_name": "Calcium carbonate",
        "arabic_commercial_name": "كربونات الكاسيوم",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 10,
        "price_after_discount": 4500,
        "is_favourite": false,
        "arabic_description":
            "كل مضغوطة تحتوي على 200 وحدة دولية من الكالسيوم.",
        "english_description": "Each tablet contains 200 IU of calcium.",
        "image_name": "m6.jpg",
        "expiration_date": "2024-03-11T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 1,
          "arabic_name": "ابن الهيثم",
          "english_name": "Ebn Alhaytham"
        },
        "effect_category": {
          "id": 5,
          "arabic_name": "مكمل غذائي",
          "english_name": "Dietary Supplement",
          "image_name": "e5.jpg"
        }
      },
      {
        "id": 33,
        "english_scientific_name": "Augmatex",
        "arabic_scientific_name": "أوغماتيكس",
        "english_commercial_name": "Amoxicillin",
        "arabic_commercial_name": "أموكسيسيللين",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description":
            "(أموكسيسيللين 875 ملغ + كلافولانيك أسيد 125 ملغ) / 14 مضغوطة.",
        "english_description":
            "(Amoxicillin 875 mg + clavulanic acid 125 mg) / 14 tablets",
        "image_name": "m7.jpg",
        "expiration_date": "2024-01-31T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 4,
          "arabic_name": "ابن زهر",
          "english_name": "Ebn Zaher"
        },
        "effect_category": {
          "id": 2,
          "arabic_name": "مضاد حيوي",
          "english_name": "Anti-inflammatory",
          "image_name": "e2.jpg"
        }
      },
      {
        "id": 34,
        "english_scientific_name": "Maxiflux",
        "arabic_scientific_name": "ماكسيفلكس",
        "english_commercial_name": "Amoxicillin",
        "arabic_commercial_name": "أموكسيسيللين",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 30,
        "price_after_discount": 3500,
        "is_favourite": false,
        "arabic_description":
            "أموكسيسيلين 125 ملغ + فلوكلوكساسيللين 125 ملغ / ٢٠ كبسولة.",
        "english_description":
            "Amoxicillin 125 mg + Flucloxacillin 125 mg / 20 capsules.",
        "image_name": "m8.jpg",
        "expiration_date": "2024-03-02T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 4,
          "arabic_name": "ابن زهر",
          "english_name": "Ebn Zaher"
        },
        "effect_category": {
          "id": 2,
          "arabic_name": "مضاد حيوي",
          "english_name": "Anti-inflammatory",
          "image_name": "e2.jpg"
        }
      },
      {
        "id": 35,
        "english_scientific_name": "Indapamide S.R.Biomed",
        "arabic_scientific_name": "إنداباميد",
        "english_commercial_name": "Indapamide",
        "arabic_commercial_name": "إنداباميد",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 30,
        "price_after_discount": 3500,
        "is_favourite": false,
        "arabic_description":
            "كل مضغوطة إنداباميد 1.5 تحتوي على 1.5 ملغ إنداباميد.",
        "english_description":
            "Each Indapamide 1.5 tablet contains 1.5 mg Indapamide.",
        "image_name": "m9.jpg",
        "expiration_date": "2024-03-06T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 3,
          "arabic_name": "بيوميد فارما",
          "english_name": "Biomed Pharma"
        },
        "effect_category": {
          "id": 3,
          "arabic_name": "منظم ضغط",
          "english_name": "Blood Pressure Regulator",
          "image_name": "e3.jpg"
        }
      },
      {
        "id": 36,
        "english_scientific_name": "Telmedibine",
        "arabic_scientific_name": "تيلميدبين",
        "english_commercial_name": "Telmisartan/amlodipine",
        "arabic_commercial_name": "تيلميسارتان / أملوديبين",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 30,
        "price_after_discount": 3500,
        "is_favourite": false,
        "arabic_description": "تحتوي كل مضغوطة 40 ملغ على 5 ملغ أملوديبين.",
        "english_description": "Each 40 mg tablet contains 5 mg amlodipine.",
        "image_name": "m10.jpg",
        "expiration_date": "2024-02-17T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 3,
          "arabic_name": "بيوميد فارما",
          "english_name": "Biomed Pharma"
        },
        "effect_category": {
          "id": 3,
          "arabic_name": "منظم ضغط",
          "english_name": "Blood Pressure Regulator",
          "image_name": "e3.jpg"
        }
      },
      {
        "id": 37,
        "english_scientific_name": "Zinc Ugarit",
        "arabic_scientific_name": "زنك أوغاريت",
        "english_commercial_name": "Zinc",
        "arabic_commercial_name": "زنك",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description": "تحتوي كل مضغوطة على 50 ملغ زنك.",
        "english_description": "Each tablet contains 50 mg zinc.",
        "image_name": "m11.jpg",
        "expiration_date": "2023-12-24T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 5,
          "arabic_name": "أوغاريت",
          "english_name": "Ugarit"
        },
        "effect_category": {
          "id": 5,
          "arabic_name": "مكمل غذائي",
          "english_name": "Dietary Supplement",
          "image_name": "e5.jpg"
        }
      },
      {
        "id": 38,
        "english_scientific_name": "Omega3",
        "arabic_scientific_name": "أوميغا3",
        "english_commercial_name": "Omega3",
        "arabic_commercial_name": "أوميغا3",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description":
            "تحتوي كل كبسولة من مستحضر  أوميغا-3 فورت على 500 مغ من خلاصة الطحالب البحرية الفائقة النعومة الحاوية على الحموض الدسمة التالية : حمض ايكوسابنتانوئيك (EPA) / حمض ديكوساهيكسانوئيك / حمض النخيل / حمض جوزة الطيب.",
        "english_description":
            "Each capsule of Omega-3 Forte contains 500 mg of ultra-fine marine algae extract containing the following fatty acids: eicosapentaenoic acid (EPA) / dicosahexaenoic acid / palmitic acid / nutmeg acid.",
        "image_name": "m12.jpg",
        "expiration_date": "2024-02-06T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 5,
          "arabic_name": "أوغاريت",
          "english_name": "Ugarit"
        },
        "effect_category": {
          "id": 5,
          "arabic_name": "مكمل غذائي",
          "english_name": "Dietary Supplement",
          "image_name": "e5.jpg"
        }
      },
      {
        "id": 39,
        "english_scientific_name": "Ginseng B Complex",
        "arabic_scientific_name": "جينسنغ ب كومبلكس",
        "english_commercial_name": "B Complex",
        "arabic_commercial_name": "ب كومبلكس",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 30,
        "price_after_discount": 3500,
        "is_favourite": false,
        "arabic_description": "يحتوي على فيتامينات ب1 ب2 ب5 ب6 ب12.",
        "english_description":
            "It contains vitamins : B1, B2, B5, B6, and B12.",
        "image_name": "m13.jpg",
        "expiration_date": "2024-02-24T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 5,
          "arabic_name": "أوغاريت",
          "english_name": "Ugarit"
        },
        "effect_category": {
          "id": 5,
          "arabic_name": "مكمل غذائي",
          "english_name": "Dietary Supplement",
          "image_name": "e5.jpg"
        }
      },
      {
        "id": 40,
        "english_scientific_name": "Unadol blue",
        "arabic_scientific_name": "بندول أزرق",
        "english_commercial_name": "Paracetamol",
        "arabic_commercial_name": "باراسيتامول",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 30,
        "price_after_discount": 3500,
        "is_favourite": false,
        "arabic_description": "كل مضغوطة تحتوي على: 500 ملغ باراسيتامول.",
        "english_description":
            "Each film coated tablets contains: 500 mg Paracetamol.",
        "image_name": "m1.jpg",
        "expiration_date": "2024-02-14T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 2,
          "arabic_name": "يونفارما",
          "english_name": "Unipharma"
        },
        "effect_category": {
          "id": 1,
          "arabic_name": "مسكن آلام",
          "english_name": "Analgesics",
          "image_name": "e1.jpg"
        }
      },
      {
        "id": 41,
        "english_scientific_name": "Unadol red",
        "arabic_scientific_name": "بندول أحمر",
        "english_commercial_name": "Paracetamol",
        "arabic_commercial_name": "باراسيتامول",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 30,
        "price_after_discount": 3500,
        "is_favourite": false,
        "arabic_description":
            "يحتوي كل قرص مغلف على: 500 ملغ باراسيتامول و 65 ملغ كافيين.",
        "english_description":
            "Each film coated tablet contains: 500mg  Paracetamol & 65 mg Caffeine..",
        "image_name": "m2.jpg",
        "expiration_date": "2024-02-25T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 2,
          "arabic_name": "يونفارما",
          "english_name": "Unipharma"
        },
        "effect_category": {
          "id": 1,
          "arabic_name": "مسكن آلام",
          "english_name": "Analgesics",
          "image_name": "e1.jpg"
        }
      },
      {
        "id": 42,
        "english_scientific_name": "Unadol yellow",
        "arabic_scientific_name": "بندول أصفر",
        "english_commercial_name": "Paracetamol",
        "arabic_commercial_name": "باراسيتامول",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 30,
        "price_after_discount": 3500,
        "is_favourite": false,
        "arabic_description":
            "يحتوي كل قرص مغلف على: 500 ملغ باراسيتامول، كافيين 25 ملغ، فينيليفرين هيدروكلورايد 5 ملغ.",
        "english_description":
            "Each film coated tablets contains: 500 mg Paracetamol, Caffeine 25 mg, Phenylephrine Hydrocloride 5 mg.",
        "image_name": "m3.jpg",
        "expiration_date": "2024-02-25T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 2,
          "arabic_name": "يونفارما",
          "english_name": "Unipharma"
        },
        "effect_category": {
          "id": 1,
          "arabic_name": "مسكن آلام",
          "english_name": "Analgesics",
          "image_name": "e1.jpg"
        }
      },
      {
        "id": 43,
        "english_scientific_name": "Clarityn",
        "arabic_scientific_name": "كلاريتين",
        "english_commercial_name": "Loratadine",
        "arabic_commercial_name": "لوراتيدين",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description": "يحتوي كل قرص على: 10 ملغ من لوراتادين.",
        "english_description": "Each tablet contains: 10 mg loratadine.",
        "image_name": "m4.jpg",
        "expiration_date": "2024-01-31T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 2,
          "arabic_name": "يونفارما",
          "english_name": "Unipharma"
        },
        "effect_category": {
          "id": 4,
          "arabic_name": "مضاد هسيتامين",
          "english_name": "Anti-histamine",
          "image_name": "e4.jpg"
        }
      },
      {
        "id": 44,
        "english_scientific_name": "SelSun",
        "arabic_scientific_name": "سيلسن",
        "english_commercial_name": "Selenium Sulphide Lotion",
        "arabic_commercial_name": "غسول كبريتيد السيلينيوم",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description":
            "غسول كبريتيد السيلينيوم هو مستحضر سائل مضاد للدهون ومضاد للفطريات يحتوي على كبريتيد السيلينيوم 2.5% وزن/حجم في محلول مائي، وهو مخصص للاستخدام الموضعي.",
        "english_description":
            "SELSEN (Selenium Sulfide Lotion) is a liquid antiseborrheic, antifungal preparation containing selenium sulfide 2,5% w/v in an aqueous suspension, and is intended for topical application.",
        "image_name": "m5.jpg",
        "expiration_date": "2024-02-06T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 2,
          "arabic_name": "يونفارما",
          "english_name": "Unipharma"
        },
        "effect_category": {
          "id": 6,
          "arabic_name": "مضاد قشرة",
          "english_name": "Anti-dandruff",
          "image_name": "e6.jpg"
        }
      },
      {
        "id": 45,
        "english_scientific_name": "Calcium",
        "arabic_scientific_name": "كالسيوم",
        "english_commercial_name": "Calcium carbonate",
        "arabic_commercial_name": "كربونات الكاسيوم",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 30,
        "price_after_discount": 3500,
        "is_favourite": false,
        "arabic_description":
            "كل مضغوطة تحتوي على 200 وحدة دولية من الكالسيوم.",
        "english_description": "Each tablet contains 200 IU of calcium.",
        "image_name": "m6.jpg",
        "expiration_date": "2024-03-01T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 1,
          "arabic_name": "ابن الهيثم",
          "english_name": "Ebn Alhaytham"
        },
        "effect_category": {
          "id": 5,
          "arabic_name": "مكمل غذائي",
          "english_name": "Dietary Supplement",
          "image_name": "e5.jpg"
        }
      },
      {
        "id": 46,
        "english_scientific_name": "Augmatex",
        "arabic_scientific_name": "أوغماتيكس",
        "english_commercial_name": "Amoxicillin",
        "arabic_commercial_name": "أموكسيسيللين",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description":
            "(أموكسيسيللين 875 ملغ + كلافولانيك أسيد 125 ملغ) / 14 مضغوطة.",
        "english_description":
            "(Amoxicillin 875 mg + clavulanic acid 125 mg) / 14 tablets",
        "image_name": "m7.jpg",
        "expiration_date": "2023-12-15T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 4,
          "arabic_name": "ابن زهر",
          "english_name": "Ebn Zaher"
        },
        "effect_category": {
          "id": 2,
          "arabic_name": "مضاد حيوي",
          "english_name": "Anti-inflammatory",
          "image_name": "e2.jpg"
        }
      },
      {
        "id": 47,
        "english_scientific_name": "Maxiflux",
        "arabic_scientific_name": "ماكسيفلكس",
        "english_commercial_name": "Amoxicillin",
        "arabic_commercial_name": "أموكسيسيللين",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 30,
        "price_after_discount": 3500,
        "is_favourite": false,
        "arabic_description":
            "أموكسيسيلين 125 ملغ + فلوكلوكساسيللين 125 ملغ / ٢٠ كبسولة.",
        "english_description":
            "Amoxicillin 125 mg + Flucloxacillin 125 mg / 20 capsules.",
        "image_name": "m8.jpg",
        "expiration_date": "2024-02-11T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 4,
          "arabic_name": "ابن زهر",
          "english_name": "Ebn Zaher"
        },
        "effect_category": {
          "id": 2,
          "arabic_name": "مضاد حيوي",
          "english_name": "Anti-inflammatory",
          "image_name": "e2.jpg"
        }
      },
      {
        "id": 48,
        "english_scientific_name": "Indapamide S.R.Biomed",
        "arabic_scientific_name": "إنداباميد",
        "english_commercial_name": "Indapamide",
        "arabic_commercial_name": "إنداباميد",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description":
            "كل مضغوطة إنداباميد 1.5 تحتوي على 1.5 ملغ إنداباميد.",
        "english_description":
            "Each Indapamide 1.5 tablet contains 1.5 mg Indapamide.",
        "image_name": "m9.jpg",
        "expiration_date": "2023-12-12T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 3,
          "arabic_name": "بيوميد فارما",
          "english_name": "Biomed Pharma"
        },
        "effect_category": {
          "id": 3,
          "arabic_name": "منظم ضغط",
          "english_name": "Blood Pressure Regulator",
          "image_name": "e3.jpg"
        }
      },
      {
        "id": 49,
        "english_scientific_name": "Telmedibine",
        "arabic_scientific_name": "تيلميدبين",
        "english_commercial_name": "Telmisartan/amlodipine",
        "arabic_commercial_name": "تيلميسارتان / أملوديبين",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 30,
        "price_after_discount": 3500,
        "is_favourite": false,
        "arabic_description": "تحتوي كل مضغوطة 40 ملغ على 5 ملغ أملوديبين.",
        "english_description": "Each 40 mg tablet contains 5 mg amlodipine.",
        "image_name": "m10.jpg",
        "expiration_date": "2024-02-09T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 3,
          "arabic_name": "بيوميد فارما",
          "english_name": "Biomed Pharma"
        },
        "effect_category": {
          "id": 3,
          "arabic_name": "منظم ضغط",
          "english_name": "Blood Pressure Regulator",
          "image_name": "e3.jpg"
        }
      },
      {
        "id": 50,
        "english_scientific_name": "Zinc Ugarit",
        "arabic_scientific_name": "زنك أوغاريت",
        "english_commercial_name": "Zinc",
        "arabic_commercial_name": "زنك",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 50,
        "price_after_discount": 2500,
        "is_favourite": false,
        "arabic_description": "تحتوي كل مضغوطة على 50 ملغ زنك.",
        "english_description": "Each tablet contains 50 mg zinc.",
        "image_name": "m11.jpg",
        "expiration_date": "2023-12-23T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 5,
          "arabic_name": "أوغاريت",
          "english_name": "Ugarit"
        },
        "effect_category": {
          "id": 5,
          "arabic_name": "مكمل غذائي",
          "english_name": "Dietary Supplement",
          "image_name": "e5.jpg"
        }
      },
      {
        "id": 51,
        "english_scientific_name": "Omega3",
        "arabic_scientific_name": "أوميغا3",
        "english_commercial_name": "Omega3",
        "arabic_commercial_name": "أوميغا3",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 10,
        "price_after_discount": 4500,
        "is_favourite": false,
        "arabic_description":
            "تحتوي كل كبسولة من مستحضر  أوميغا-3 فورت على 500 مغ من خلاصة الطحالب البحرية الفائقة النعومة الحاوية على الحموض الدسمة التالية : حمض ايكوسابنتانوئيك (EPA) / حمض ديكوساهيكسانوئيك / حمض النخيل / حمض جوزة الطيب.",
        "english_description":
            "Each capsule of Omega-3 Forte contains 500 mg of ultra-fine marine algae extract containing the following fatty acids: eicosapentaenoic acid (EPA) / dicosahexaenoic acid / palmitic acid / nutmeg acid.",
        "image_name": "m12.jpg",
        "expiration_date": "2024-03-21T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 5,
          "arabic_name": "أوغاريت",
          "english_name": "Ugarit"
        },
        "effect_category": {
          "id": 5,
          "arabic_name": "مكمل غذائي",
          "english_name": "Dietary Supplement",
          "image_name": "e5.jpg"
        }
      },
      {
        "id": 52,
        "english_scientific_name": "Ginseng B Complex",
        "arabic_scientific_name": "جينسنغ ب كومبلكس",
        "english_commercial_name": "B Complex",
        "arabic_commercial_name": "ب كومبلكس",
        "available_quantity": Random().nextInt(1000) + 200,
        "price": 5000,
        "discount": 30,
        "price_after_discount": 3500,
        "is_favourite": false,
        "arabic_description": "يحتوي على فيتامينات ب1 ب2 ب5 ب6 ب12.",
        "english_description":
            "It contains vitamins : B1, B2, B5, B6, and B12.",
        "image_name": "m13.jpg",
        "expiration_date": "2024-02-24T00:00:00.000000Z",
        "created_at": "2023-12-12T00:00:00.000000Z",
        "manufacturer": {
          "id": 5,
          "arabic_name": "أوغاريت",
          "english_name": "Ugarit"
        },
        "effect_category": {
          "id": 5,
          "arabic_name": "مكمل غذائي",
          "english_name": "Dietary Supplement",
          "image_name": "e5.jpg"
        }
      }
    ]
  },
  "message": {"custom_message": "All medicines retrieved successfully."}
};
