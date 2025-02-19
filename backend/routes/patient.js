const express = require("express");
const Patient = require("../models/Patient");

const router = express.Router();

// Create a new patient
router.post("/", async (req, res) => {
  const { name, age, gender, address } = req.body;
  try {
    const newPatient = new Patient({ name, age, gender, address });
    await newPatient.save();
    console.log("new patient created");
    res.status(201).json(newPatient);
  } catch (err) {
    res.status(500).json({ message: "Server error" });
  }
});

// Get all patients
router.get("/", async (req, res) => {
  try {
    const patients = await Patient.find();
    res.status(200).json(patients);
  } catch (err) {
    res.status(500).json({ message: "Server error" });
  }
});

// Get a single patient by ID
router.get("/:id", async (req, res) => {
  try {
    const patient = await Patient.findById(req.params.id);
    if (!patient) {
      return res.status(404).json({ message: "Patient not found" });
    }
    res.status(200).json(patient);
  } catch (err) {
    res.status(500).json({ message: "Server error" });
  }
});

// Update a patient's information
router.put("/:id", async (req, res) => {
  const { name, age, gender, address } = req.body;
  try {
    const patient = await Patient.findByIdAndUpdate(
      req.params.id,
      { name, age, gender, address },
      { new: true }
    );
    if (!patient) {
      return res.status(404).json({ message: "Patient not found" });
    }
    res.status(200).json(patient);
  } catch (err) {
    res.status(500).json({ message: "Server error" });
  }
});

// Delete a patient by ID
router.delete("/:id", async (req, res) => {
  try {
    const patient = await Patient.findByIdAndDelete(req.params.id);
    if (!patient) {
      return res.status(404).json({ message: "Patient not found" });
    }
    res.status(200).json({ message: "Patient deleted" });
  } catch (err) {
    res.status(500).json({ message: "Server error" });
  }
});

module.exports = router;
