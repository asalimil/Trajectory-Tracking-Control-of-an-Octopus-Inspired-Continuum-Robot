# Trajectory-Tracking-Control-of-an-Octopus-Inspired-Continuum-Robot
This repository contains Matlab codes associated with the following research paper: 

@article{lafmejani2020kinematic,
  title={Kinematic modeling and trajectory tracking control of an octopus-inspired hyper-redundant robot},
  author={Lafmejani, Amir Salimi and Doroudchi, Azadeh and Farivarnejad, Hamed and He, Ximin and Aukes, Daniel and Peet, Matthew M and Marvi, Hamidreza and Fisher, Rebecca E and Berman, Spring},
  journal={IEEE Robotics and Automation Letters},
  volume={5},
  number={2},
  pages={3460--3467},
  year={2020},
  publisher={IEEE}
}

This project addresses the kinematic modeling and control of continuum robots inspired by the octopus arm. We propose a discrete multi-segment model in which each segment is a 6-DoF Gough-Stewart parallel platform. Our model is novel in that it can reproduce all generic motions of an octopus arm, including elongation, shortening, bending, and particularly twisting, which is usually not included in such models, while enforcing the constant-volume property of the octopus arm. We use an approach that is inspired by the unique decentralized nervous system of the octopus arm to overcome challenges in solving the Inverse Kinematics (IK) problem, including a large number of solutions for this problem and the impracticality of numerical methods for real-time applications. We apply the pseudo-inverse Jacobian method to design a kinematic controller that drives the tip of the continuum robot to track a reference trajectory. We evaluate our proposed model and controller in simulation for a variety of 3D reference trajectories: a straight line, an ellipse, a sinusoidal path, and trajectories that we observed in a live octopus.  The tip of the simulated continuum robot tracks the reference trajectories with average root-mean-square errors that are less than 0.3% of the robot's initial length, demonstrating the effectiveness of our modeling and control approaches.
