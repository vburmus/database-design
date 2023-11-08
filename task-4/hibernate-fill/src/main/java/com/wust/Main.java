package com.wust;

import com.wust.entities.*;
import com.wust.entities.primarykeys.EntryPK;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import lombok.ToString;
import lombok.val;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Random;
import java.util.Set;

import net.datafaker.Faker;

public class Main {
    private static final EntityManagerFactory EMF = Persistence.createEntityManagerFactory("default");
    private static final EntityManager EM = EMF.createEntityManager();

    private static final int SPECIALIZATIONS_AMOUNT = 41;
    // !Users = doctors + patients + pharmacists!
    private static final int USERS_AMOUNT = 10_000;
    private static final int DOCTORS_AMOUNT = 5_000;
    private static final int PATIENTS_AMOUNT = 4_000;
    private static final int PHARMACISTS_AMOUNT = 3_000;
    private static final int PHARMACIES_AMOUNT = 600;
    private static final int ALLERGIES_AMOUNT = 100;
    private static final int PHARMACEUTICAL_FORMS_AMOUNT = 250;
    private static final int SUBSTANCES_AMOUNT = 5_000;
    private static final int MEDICINES_AMOUNT = 10_000;
    private static final int PRESCRIPTIONS_AMOUNT = 10_000;

    private static final Random RANDOM = new Random();

    private static final Set<String> EMAILS = new HashSet<>();
    private static final Set<String> LOGINS = new HashSet<>();
    private static final Set<String> ALLERGIES = new HashSet<>();
    private static final Set<String> SUBSTANCIES = new HashSet<>();
    private static final Set<String> PERMIT_NUMBERS = new HashSet<>();
    private static final Set<String> PHARMACIES_NAMES = new HashSet<>();
    private static final Category[] CATEGORIES = new Category[14];
    private static final Faker faker = new Faker(new Locale("pl"));

    public static void main(String[] args) {

        try {
            initSpecializations();
            initDoctors();
            initAllergies();
            initCategories();
            initPatients();
            initPharmaceuticalForms();
            initSubstances();
            initPharmacists();
            initPharmacies();
            initMedicine();
            initPrescriptions();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            EM.close();
            EMF.close();
        }
    }

    private static void initSpecializations() {
        EntityTransaction transaction = EM.getTransaction();
        transaction.begin();

        for (int i = 0; i < SPECIALIZATIONS_AMOUNT; i++) {
            Specialization spec = new Specialization();
            spec.setName("specialization" + (i + 1));
            EM.persist(spec);
        }

        transaction.commit();
    }

    private static User generateUser() {
        User user = new User();

        user.setPhoneNumber(faker.phoneNumber().cellPhone());
        user.setEmail(faker.internet().emailAddress());
        while (EMAILS.contains(user.getEmail())) {
            user.setEmail(faker.internet().emailAddress());
        }
        EMAILS.add(user.getEmail());
        user.setLogin(faker.name().username());
        while (LOGINS.contains(user.getLogin())) {
            user.setLogin(faker.name().username());
        }
        user.setPassword(faker.internet().password());
        user.setIsAdmin(false);
        EM.persist(user);

        return user;
    }

    private static void initDoctors() {
        EntityTransaction transaction = EM.getTransaction();
        transaction.begin();

        for (int i = 0; i < DOCTORS_AMOUNT; i++) {
            Doctor doc = new Doctor();

            doc.setFirstName(faker.name().firstName());
            doc.setLastName(faker.name().lastName());
            doc.setPwzNumber(String.format("%07d", (i + 1)));

            User user = generateUser();
            doc.setUser(user);
            doc.setPesel(faker.idNumber().peselNumber());

            doc.setSpecializations(getRandomSpecializations(null));

            EM.persist(doc);
        }

        transaction.commit();
    }

    private static void initAllergies() {
        EntityTransaction transaction = EM.getTransaction();
        transaction.begin();

        for (int i = 0; i < ALLERGIES_AMOUNT; i++) {
            Allergy allergy = new Allergy();

            allergy.setName(faker.disease().dermatology());
            int max = 10;
            while (ALLERGIES.contains(allergy.getName())) {
                allergy.setName(faker.disease().dermatology());
                max--;
                if (max == 0) {
                    allergy.setName(getRandomString(10));
                    break;
                }
            }
            ALLERGIES.add(allergy.getName());
            allergy.setDescription("Allergy has " + (i + 1) + " level of danger");
            EM.persist(allergy);
        }

        transaction.commit();
    }

    private static void initCategories() {
        EntityTransaction transaction = EM.getTransaction();
        transaction.begin();

        Category cat1 = new Category();
        cat1.setSymbol("A");
        cat1.setDescription("Alimentary tract and metabolism");
        cat1.setSpecializations(getRandomSpecializations(5));
        CATEGORIES[0] = cat1;
        EM.persist(cat1);

        Category cat2 = new Category();
        cat2.setSymbol("B");
        cat2.setDescription("Blood and blood forming organs");
        cat2.setSpecializations(getRandomSpecializations(5));
        CATEGORIES[1] = cat2;
        EM.persist(cat2);

        Category cat3 = new Category();
        cat3.setSymbol("C");
        cat3.setDescription("Cardiovascular system");
        cat3.setSpecializations(getRandomSpecializations(5));
        CATEGORIES[2] = cat3;
        EM.persist(cat3);

        Category cat4 = new Category();
        cat4.setSymbol("D");
        cat4.setDescription("Dermatologicals");
        cat4.setSpecializations(getRandomSpecializations(5));
        CATEGORIES[3] = cat4;
        EM.persist(cat4);

        Category cat5 = new Category();
        cat5.setSymbol("G");
        cat5.setDescription("Genito-urinary system and sex hormones");
        cat5.setSpecializations(getRandomSpecializations(5));
        CATEGORIES[4] = cat5;
        EM.persist(cat5);

        Category cat6 = new Category();
        cat6.setSymbol("H");
        cat6.setDescription("Systemic hormonal preparations, excluding sex hormones and insulins");
        cat6.setSpecializations(getRandomSpecializations(5));
        CATEGORIES[5] = cat6;
        EM.persist(cat6);

        Category cat7 = new Category();
        cat7.setSymbol("J");
        cat7.setDescription("Antiinfectives for systemic use");
        cat7.setSpecializations(getRandomSpecializations(5));
        CATEGORIES[6] = cat7;
        EM.persist(cat7);

        Category cat8 = new Category();
        cat8.setSymbol("L");
        cat8.setDescription("Antineoplastic and immunomodulating agents");
        cat8.setSpecializations(getRandomSpecializations(5));
        CATEGORIES[7] = cat8;
        EM.persist(cat8);

        Category cat9 = new Category();
        cat9.setSymbol("M");
        cat9.setDescription("Musculo-skeletal system");
        cat9.setSpecializations(getRandomSpecializations(5));
        CATEGORIES[8] = cat9;
        EM.persist(cat9);

        Category cat10 = new Category();
        cat10.setSymbol("N");
        cat10.setDescription("Nervous system");
        cat10.setSpecializations(getRandomSpecializations(5));
        CATEGORIES[9] = cat10;
        EM.persist(cat10);

        Category cat11 = new Category();
        cat11.setSymbol("P");
        cat11.setDescription("Antiparasitic products, insecticides and repellents");
        cat11.setSpecializations(getRandomSpecializations(5));
        CATEGORIES[10] = cat11;
        EM.persist(cat11);

        Category cat12 = new Category();
        cat12.setSymbol("R");
        cat12.setDescription("Respiratory system");
        cat12.setSpecializations(getRandomSpecializations(5));
        CATEGORIES[11] = cat12;
        EM.persist(cat12);

        Category cat13 = new Category();
        cat13.setSymbol("S");
        cat13.setDescription("Sensory organs");
        cat13.setSpecializations(getRandomSpecializations(5));
        CATEGORIES[12] = cat13;
        EM.persist(cat13);

        Category cat14 = new Category();
        cat14.setSymbol("V");
        cat14.setDescription("Various");
        cat14.setSpecializations(getRandomSpecializations(5));
        CATEGORIES[13] = cat14;
        EM.persist(cat14);

        transaction.commit();
    }

    private static void initPatients() {
        EntityTransaction transaction = EM.getTransaction();
        transaction.begin();

        for (int i = 0; i < PATIENTS_AMOUNT; i++) {
            Patient patient = new Patient();

            patient.setFirstName(faker.name().firstName());
            patient.setLastName(faker.name().lastName());

            User user = generateUser();
            patient.setUser(user);
            patient.setPesel(faker.idNumber().peselNumber());

            patient.setAllergies(getRandomAllergies(5));

            EM.persist(patient);
        }

        transaction.commit();
    }

    private static void initPharmaceuticalForms() {
        EntityTransaction transaction = EM.getTransaction();
        transaction.begin();

        for (int i = 0; i < PHARMACEUTICAL_FORMS_AMOUNT; i++) {
            PharmaceuticalForm phf = new PharmaceuticalForm();
            phf.setName("Form" + (i + 1));
            EM.persist(phf);
        }

        transaction.commit();
    }

    private static void initSubstances() {
        EntityTransaction transaction = EM.getTransaction();
        transaction.begin();

        for (int i = 0; i < SUBSTANCES_AMOUNT; i++) {
            Substance substance = new Substance();
            substance.setName(faker.food().ingredient());
            int max = 10;
            while (SUBSTANCIES.contains(substance.getName())) {
                substance.setName(faker.food().ingredient());
                max--;
                if (max == 0) {
                    substance.setName(getRandomString(10));
                    break;
                }
            }
            SUBSTANCIES.add(substance.getName());
            Set<Allergy> allergies = getRandomAllergies(3);
            if (!allergies.isEmpty()) {
                substance.setAllergies(allergies);
            }

            substance.setSource(getRandomSource());
            EM.persist(substance);
        }

        transaction.commit();
    }

    private static void initPharmacists() {
        EntityTransaction transaction = EM.getTransaction();
        transaction.begin();

        for (int i = 0; i < PHARMACISTS_AMOUNT; i++) {
            Pharmacist pharmacist = new Pharmacist();

            pharmacist.setFirstName(faker.name().firstName());
            pharmacist.setLastName(faker.name().lastName());
            pharmacist.setPwzfNumber(String.format("%07d", (i + 1)));

            User user = generateUser();
            pharmacist.setUser(user);
            pharmacist.setPesel(faker.idNumber().peselNumber());

            EM.persist(pharmacist);
        }

        transaction.commit();
    }

    private static void initPharmacies() {
        EntityTransaction transaction = EM.getTransaction();
        transaction.begin();

        for (int i = 0; i < PHARMACIES_AMOUNT; i++) {
            Pharmacy pharmacy = new Pharmacy();

            pharmacy.setName(faker.company().name());
            pharmacy.setAddress(faker.address().streetAddress() + " " + faker.address().buildingNumber());
            pharmacy.setPhoneNumber(faker.phoneNumber().phoneNumber());
            pharmacy.setPermitNumber(String.format("%011d", (i + 1)));
            pharmacy.setPharmacists(getRandomPharmacists(null));

            EM.persist(pharmacy);
        }

        transaction.commit();
    }

    private static void initMedicine() {
        EntityTransaction transaction = EM.getTransaction();
        transaction.begin();

        for (int i = 0; i < MEDICINES_AMOUNT; i++) {
            Medicine medicine = new Medicine();

            medicine.setName(faker.medical().medicineName());
            int max = 10;
            while (PHARMACIES_NAMES.contains(medicine.getName())) {
                medicine.setName(faker.medical().medicineName());
                if (max == 0) {
                    medicine.setName(getRandomString(10));
                    break;
                }
            }
            medicine.setPermitNumber(getRandomString(5));
            while (PERMIT_NUMBERS.contains(medicine.getPermitNumber())) {
                medicine.setPermitNumber(getRandomString(5));
            }
            medicine.setPharmaceuticalForm(
                    EM.find(PharmaceuticalForm.class, RANDOM.nextInt(PHARMACEUTICAL_FORMS_AMOUNT) + 1));
            medicine.setCategory(CATEGORIES[RANDOM.nextInt(CATEGORIES.length)]);
            medicine.setSubstances(getRandomSubstances(null));

            EM.persist(medicine);
        }

        transaction.commit();
    }

    private static void initPrescriptions() {
        EntityTransaction transaction = EM.getTransaction();
        transaction.begin();

        for (int i = 0; i < PRESCRIPTIONS_AMOUNT; i++) {
            Prescription prescription = new Prescription();

            prescription.setDoctor(EM.find(Doctor.class, RANDOM.nextInt(DOCTORS_AMOUNT) + 1));
            prescription.setPatient(EM.find(Patient.class, RANDOM.nextInt(PATIENTS_AMOUNT) + 1));
            prescription.setIssueDate(new Timestamp(faker.date().birthday(0, 100).getTime()).toLocalDateTime());
            prescription.setIsCancelled(false);
            EM.persist(prescription);
            prescription.setEntries(generateEntries(RANDOM.nextInt(10) + 1, prescription));
            EM.merge(prescription);
        }

        transaction.commit();
    }

    private static Set<Entry> generateEntries(int how_many, Prescription prescription) {
        Set<Entry> entries = new HashSet<>();
        Set<Medicine> medicines = new HashSet<>();
        for (int i = 0; i < how_many; i++) {
            Entry entry = new Entry();
            entry.setMedicine(EM.find(Medicine.class, RANDOM.nextInt(MEDICINES_AMOUNT) + 1));
            while (medicines.contains(entry.getMedicine())) {
                entry.setMedicine(EM.find(Medicine.class, RANDOM.nextInt(MEDICINES_AMOUNT) + 1));
            }
            medicines.add(entry.getMedicine());
            entry.setPrescription(prescription);
            entry.setEntryPK(new EntryPK(entry.getMedicine().getId(), prescription.getId()));
            entry.setQuantity(RANDOM.nextInt(10) + 1);
            entry.setDosage(String.valueOf(RANDOM.nextInt(10) + 1) + " ml/" + String.valueOf(RANDOM.nextInt(7) + 1));
            entry.setStatus(Status.values()[RANDOM.nextInt(Status.values().length)]);
            entry.setPharmacist(EM.find(Pharmacist.class, RANDOM.nextInt(PHARMACISTS_AMOUNT) + 1));
            EM.persist(entry);

            entries.add(entry);
        }

        return entries;
    }

    private static Set<Specialization> getRandomSpecializations(Integer max) {
        Set<Specialization> specializations = new HashSet<>();

        if (max == null) {
            max = RANDOM.nextInt(SPECIALIZATIONS_AMOUNT) + 1;
        }

        for (int i = 0; i < RANDOM.nextInt(max); i++) {
            int randomSpecId = RANDOM.nextInt(SPECIALIZATIONS_AMOUNT) + 1;
            Specialization specialization = EM.find(Specialization.class, randomSpecId);
            specializations.add(specialization);
        }

        return specializations;
    }

    private static Set<Allergy> getRandomAllergies(Integer max) {
        Set<Allergy> allergies = new HashSet<>();

        if (max == null) {
            max = RANDOM.nextInt(SPECIALIZATIONS_AMOUNT) + 1;
        }

        for (int i = 0; i < RANDOM.nextInt(max); i++) {
            int randomAllergyId = RANDOM.nextInt(ALLERGIES_AMOUNT) + 1;
            Allergy allergy = EM.find(Allergy.class, randomAllergyId);
            allergies.add(allergy);
        }

        return allergies;
    }

    private static Set<Pharmacist> getRandomPharmacists(Integer max) {
        Set<Pharmacist> pharmacists = new HashSet<>();

        if (max == null) {
            max = RANDOM.nextInt(5) + 1;
        }
        for (int i = 0; i < max; i++) {
            int randomPharmacistId = RANDOM.nextInt(PHARMACISTS_AMOUNT) + 1;
            Pharmacist pharmacist = EM.find(Pharmacist.class, randomPharmacistId);
            pharmacists.add(pharmacist);
        }

        return pharmacists;
    }

    private static Set<Substance> getRandomSubstances(Integer max) {
        Set<Substance> substances = new HashSet<>();

        if (max == null) {
            max = RANDOM.nextInt(5) + 1;
        }
        for (int i = 0; i < max; i++) {
            int randomSubstanceId = RANDOM.nextInt(SUBSTANCES_AMOUNT) + 1;
            Substance substance = EM.find(Substance.class, randomSubstanceId);
            substances.add(substance);
        }

        return substances;
    }

    private static Source getRandomSource() {
        int randomNumber = RANDOM.nextInt(2) + 1;

        if (randomNumber == 1) {
            return Source.NATURAL;
        } else {
            return Source.SYNTHETIC;
        }
    }

    private static String getRandomString(int max) {
        String validChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        StringBuilder randomString = new StringBuilder();

        for (int i = 0; i < max; i++) {
            int randomIndex = RANDOM.nextInt(validChars.length());
            char randomChar = validChars.charAt(randomIndex);
            randomString.append(randomChar);
        }

        return randomString.toString();
    }
}