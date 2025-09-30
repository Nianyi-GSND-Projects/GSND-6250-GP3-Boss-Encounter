using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class ButtonController : MonoBehaviour
{
    [SerializeField] private LaserLauncher[] controlledLaser;

    [SerializeField] private float Cooldown = 30.0f;
    
    private float cooldownTimer = 0.0f;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (cooldownTimer > 0.0f)
            {
            cooldownTimer -= Time.deltaTime;
            }
    }

    public void OnPress()
    {
        if (cooldownTimer <= 0.0f)
        {
            cooldownTimer = Cooldown;
            foreach (LaserLauncher LL in controlledLaser)
            {
                LL.Fire();
            }
        }
    }
    
}
