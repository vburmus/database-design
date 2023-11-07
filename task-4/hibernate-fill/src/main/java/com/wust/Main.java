package com.wust;

import com.wust.entities.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;

import java.util.HashSet;
import java.util.Random;
import java.util.Set;

public class Main {
    private static final EntityManagerFactory EMF = Persistence.createEntityManagerFactory("default");
    private static final EntityManager EM = EMF.createEntityManager();

    private static final int SPECIALIZATIONS_AMOUNT = 41;
    private static final int USERS_AMOUNT = 10_000;
    private static final int DOCTORS_AMOUNT = 3_000;
    private static final int ALLERGIES_AMOUNT = 100;
    private static final int CATEGORIES_AMOUNT = 14;
    private static final int PATIENTS_AMOUNT = 4_000;

    private static final Random RANDOM = new Random();

    private static final Set<User> USED_USERS = new HashSet<>();

    public static void main(String[] args) {

        try {
            clearDB();
            initSpecializations();
            initUsers();
            initDoctors();
            initAllergies();
            initCategories();
            initPatients();

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

    private static void initUsers() {
        EntityTransaction transaction = EM.getTransaction();
        transaction.begin();

        for (int i = 0; i < USERS_AMOUNT; i++) {
            User user = new User();

            user.setPhoneNumber("+48" + RANDOM.nextInt(999_999_999 - 100_100_100 + 1));
            user.setEmail("user" + (i + 1) + "@mail.com");
            user.setLogin("user" + (i + 1));
            user.setPassword("password" + (i + 1));
            user.setIsAdmin(false);
            EM.persist(user);
        }

        transaction.commit();
    }

    private static void initDoctors() {
        EntityTransaction transaction = EM.getTransaction();
        transaction.begin();

        for (int i = 0; i < DOCTORS_AMOUNT; i++) {
            Doctor doc = new Doctor();

            doc.setFirstName("DoctorName" + (i + 1));
            doc.setLastName("DoctorSurname" + (i + 1));
            doc.setPwzNumber(String.format("%07d", (i+1)));

            User user = getRandomUser();
            doc.setUser(user);
            doc.setPesel(String.format("%011d", user.getId()));

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

            allergy.setName("allergy" + (i+1));
            allergy.setDescription("Allergy has " + (i+1) + " level of danger");

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
        EM.persist(cat1);

        Category cat2 = new Category();
        cat2.setSymbol("B");
        cat2.setDescription("Blood and blood forming organs");
        cat2.setSpecializations(getRandomSpecializations(5));
        EM.persist(cat2);

        Category cat3 = new Category();
        cat3.setSymbol("C");
        cat3.setDescription("Cardiovascular system");
        cat3.setSpecializations(getRandomSpecializations(5));
        EM.persist(cat3);

        Category cat4 = new Category();
        cat4.setSymbol("D");
        cat4.setDescription("Dermatologicals");
        cat4.setSpecializations(getRandomSpecializations(5));
        EM.persist(cat4);

        Category cat5 = new Category();
        cat5.setSymbol("G");
        cat5.setDescription("Genito-urinary system and sex hormones");
        cat5.setSpecializations(getRandomSpecializations(5));
        EM.persist(cat5);

        Category cat6 = new Category();
        cat6.setSymbol("H");
        cat6.setDescription("Systemic hormonal preparations, excluding sex hormones and insulins");
        cat6.setSpecializations(getRandomSpecializations(5));
        EM.persist(cat6);

        Category cat7 = new Category();
        cat7.setSymbol("J");
        cat7.setDescription("Antiinfectives for systemic use");
        cat7.setSpecializations(getRandomSpecializations(5));
        EM.persist(cat7);

        Category cat8 = new Category();
        cat8.setSymbol("L");
        cat8.setDescription("Antineoplastic and immunomodulating agents");
        cat8.setSpecializations(getRandomSpecializations(5));
        EM.persist(cat8);

        Category cat9 = new Category();
        cat9.setSymbol("M");
        cat9.setDescription("Musculo-skeletal system");
        cat9.setSpecializations(getRandomSpecializations(5));
        EM.persist(cat9);

        Category cat10 = new Category();
        cat10.setSymbol("N");
        cat10.setDescription("Nervous system");
        cat10.setSpecializations(getRandomSpecializations(5));
        EM.persist(cat10);

        Category cat11 = new Category();
        cat11.setSymbol("P");
        cat11.setDescription("Antiparasitic products, insecticides and repellents");
        cat11.setSpecializations(getRandomSpecializations(5));
        EM.persist(cat11);

        Category cat12 = new Category();
        cat12.setSymbol("R");
        cat12.setDescription("Respiratory system");
        cat12.setSpecializations(getRandomSpecializations(5));
        EM.persist(cat12);

        Category cat13 = new Category();
        cat13.setSymbol("S");
        cat13.setDescription("Sensory organs");
        cat13.setSpecializations(getRandomSpecializations(5));
        EM.persist(cat13);

        Category cat14 = new Category();
        cat14.setSymbol("V");
        cat14.setDescription("Various");
        cat14.setSpecializations(getRandomSpecializations(5));
        EM.persist(cat14);


        transaction.commit();
    }

    private static void initPatients() {
        EntityTransaction transaction = EM.getTransaction();
        transaction.begin();

        for (int i = 0; i < PATIENTS_AMOUNT; i++) {
            Patient patient = new Patient();

            patient.setFirstName("PatientName" + (i+1));
            patient.setLastName("PatientSurname" + (i+1));

            User user = getRandomUser();
            patient.setUser(user);
            patient.setPesel(String.format("%011d", user.getId()));

            patient.setAllergies(getRandomAllergies(5));

            EM.persist(patient);
        }

        transaction.commit();
    }

    private static User getRandomUser() {
        User user = EM.find(User.class, RANDOM.nextInt(USERS_AMOUNT) + 1);
        while (USED_USERS.contains(user)) {
            int randomUserId = RANDOM.nextInt(USERS_AMOUNT) + 1;
            user = EM.find(User.class, randomUserId);
        }
        USED_USERS.add(user);
        return user;
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

    private static void clearDB() {
        EntityTransaction transaction = EM.getTransaction();
        transaction.begin();

        EM.createNativeQuery("DELETE FROM specialization").executeUpdate();
        EM.createNativeQuery("DELETE FROM user").executeUpdate();
        EM.createNativeQuery("DELETE FROM doctor").executeUpdate();
        EM.createNativeQuery("DELETE FROM allergy").executeUpdate();

        transaction.commit();
    }
}