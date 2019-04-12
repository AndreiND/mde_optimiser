/**
 * generated by Xtext 2.14.0
 */
package uk.ac.kcl.mdeoptimise;

import org.eclipse.emf.ecore.EObject;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Algorithm Variation</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * </p>
 * <ul>
 *   <li>{@link uk.ac.kcl.mdeoptimise.AlgorithmVariation#getProbabilityVariation <em>Probability Variation</em>}</li>
 *   <li>{@link uk.ac.kcl.mdeoptimise.AlgorithmVariation#getSimpleVariation <em>Simple Variation</em>}</li>
 * </ul>
 *
 * @see uk.ac.kcl.mdeoptimise.MdeoptimisePackage#getAlgorithmVariation()
 * @model
 * @generated
 */
public interface AlgorithmVariation extends EObject
{
  /**
   * Returns the value of the '<em><b>Probability Variation</b></em>' containment reference.
   * <!-- begin-user-doc -->
   * <p>
   * If the meaning of the '<em>Probability Variation</em>' containment reference isn't clear,
   * there really should be more of a description here...
   * </p>
   * <!-- end-user-doc -->
   * @return the value of the '<em>Probability Variation</em>' containment reference.
   * @see #setProbabilityVariation(ProbabilityVariation)
   * @see uk.ac.kcl.mdeoptimise.MdeoptimisePackage#getAlgorithmVariation_ProbabilityVariation()
   * @model containment="true"
   * @generated
   */
  ProbabilityVariation getProbabilityVariation();

  /**
   * Sets the value of the '{@link uk.ac.kcl.mdeoptimise.AlgorithmVariation#getProbabilityVariation <em>Probability Variation</em>}' containment reference.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @param value the new value of the '<em>Probability Variation</em>' containment reference.
   * @see #getProbabilityVariation()
   * @generated
   */
  void setProbabilityVariation(ProbabilityVariation value);

  /**
   * Returns the value of the '<em><b>Simple Variation</b></em>' attribute.
   * <!-- begin-user-doc -->
   * <p>
   * If the meaning of the '<em>Simple Variation</em>' attribute isn't clear,
   * there really should be more of a description here...
   * </p>
   * <!-- end-user-doc -->
   * @return the value of the '<em>Simple Variation</em>' attribute.
   * @see #setSimpleVariation(String)
   * @see uk.ac.kcl.mdeoptimise.MdeoptimisePackage#getAlgorithmVariation_SimpleVariation()
   * @model
   * @generated
   */
  String getSimpleVariation();

  /**
   * Sets the value of the '{@link uk.ac.kcl.mdeoptimise.AlgorithmVariation#getSimpleVariation <em>Simple Variation</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @param value the new value of the '<em>Simple Variation</em>' attribute.
   * @see #getSimpleVariation()
   * @generated
   */
  void setSimpleVariation(String value);

} // AlgorithmVariation