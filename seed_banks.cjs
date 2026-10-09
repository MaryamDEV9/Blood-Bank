
const { initializeApp, applicationDefault } =
  require('firebase-admin/app');

const { getFirestore } =
  require('firebase-admin/firestore');

initializeApp({
  credential: applicationDefault(),
  projectId: 'blood-bank-724db',
});

const db = getFirestore();

const banks = [
  {
    name: 'شبرا العام',
    nameEn: 'Shubra General Blood Bank',
    address: '76 ش المستشفى - شبرا، داخل مستشفى شبرا العام - كتشنر',
    phone: '22352325',
  },
  {
    name: 'المنيرة',
    nameEn: 'El Mounira Blood Bank',
    address: '2 ش نوبار - السيدة زينب، داخل مستشفى المنيرة العام',
    phone: '23910230',
  },
  {
    name: 'منشية البكري',
    nameEn: 'Manshiet El Bakry Blood Bank',
    address: 'ش جسر السويس، داخل مستشفى منشية البكري العام',
    phone: '22580946',
  },
  {
    name: 'دار السلام المركزي',
    nameEn: 'Dar El Salam Central Blood Bank',
    address: '987 ش كورنيش النيل - الملك الصالح، داخل مستشفى دار السلام العام - هرمل',
    phone: '22367769',
  },
  {
    name: 'الخازندارة',
    nameEn: 'El Khazandara Blood Bank',
    address: '3 ش شيبان - شبرا، داخل مستشفى الخازندارة العام',
    phone: '22057593',
  },
];

async function main() {
  const collection = db.collection('blood_banks');
  let added = 0;
  let skipped = 0;

  for (const bank of banks) {
    const existing = await collection
      .where('nameEn', '==', bank.nameEn)
      .limit(1)
      .get();

    if (!existing.empty) {
      console.log(`موجود بالفعل: ${bank.name}`);
      skipped++;
      continue;
    }

    await collection.add({
      ...bank,
      addressEn: '',
      governorate: 'cairo',
      city: 'Cairo',
      inventory: {
        'A+': 0, 'A-': 0,
        'B+': 0, 'B-': 0,
        'AB+': 0, 'AB-': 0,
        'O+': 0, 'O-': 0,
      },
      isVerified: false,
      updatedAt: new Date().toISOString(),
      sourceUrl:
        'https://www.mohp.gov.eg/DynamicPages.aspx?page_id=35',
    });

    console.log(`تمت الإضافة: ${bank.name}`);
    added++;
  }

  console.log(`\nانتهى التنفيذ! تمت إضافة ${added}، وتخطي ${skipped}.`);
}

main().catch((error) => {
  console.error('فشلت الإضافة:', error.message);
  process.exitCode = 1;
});
