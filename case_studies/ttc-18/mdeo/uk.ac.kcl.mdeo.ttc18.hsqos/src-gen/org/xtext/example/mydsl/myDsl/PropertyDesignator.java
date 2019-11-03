/**
 * generated by Xtext 2.12.0
 */
package org.xtext.example.mydsl.myDsl;


/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Property Designator</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * </p>
 * <ul>
 *   <li>{@link org.xtext.example.mydsl.myDsl.PropertyDesignator#getInstance <em>Instance</em>}</li>
 *   <li>{@link org.xtext.example.mydsl.myDsl.PropertyDesignator#getProperty <em>Property</em>}</li>
 * </ul>
 *
 * @see org.xtext.example.mydsl.myDsl.MyDslPackage#getPropertyDesignator()
 * @model
 * @generated
 */
public interface PropertyDesignator extends Designator
{
  /**
   * Returns the value of the '<em><b>Instance</b></em>' reference.
   * <!-- begin-user-doc -->
   * <p>
   * If the meaning of the '<em>Instance</em>' reference isn't clear,
   * there really should be more of a description here...
   * </p>
   * <!-- end-user-doc -->
   * @return the value of the '<em>Instance</em>' reference.
   * @see #setInstance(Instance)
   * @see org.xtext.example.mydsl.myDsl.MyDslPackage#getPropertyDesignator_Instance()
   * @model
   * @generated
   */
  Instance getInstance();

  /**
   * Sets the value of the '{@link org.xtext.example.mydsl.myDsl.PropertyDesignator#getInstance <em>Instance</em>}' reference.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @param value the new value of the '<em>Instance</em>' reference.
   * @see #getInstance()
   * @generated
   */
  void setInstance(Instance value);

  /**
   * Returns the value of the '<em><b>Property</b></em>' reference.
   * <!-- begin-user-doc -->
   * <p>
   * If the meaning of the '<em>Property</em>' reference isn't clear,
   * there really should be more of a description here...
   * </p>
   * <!-- end-user-doc -->
   * @return the value of the '<em>Property</em>' reference.
   * @see #setProperty(Property)
   * @see org.xtext.example.mydsl.myDsl.MyDslPackage#getPropertyDesignator_Property()
   * @model
   * @generated
   */
  Property getProperty();

  /**
   * Sets the value of the '{@link org.xtext.example.mydsl.myDsl.PropertyDesignator#getProperty <em>Property</em>}' reference.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @param value the new value of the '<em>Property</em>' reference.
   * @see #getProperty()
   * @generated
   */
  void setProperty(Property value);

} // PropertyDesignator