// ========================================
// ÁRBOL DE NAVIDAD 3D CON PARTÍCULAS
// ========================================

// Variables globales
let scene, camera, renderer, treeParticles, star, fallingParticles;
let rotationSpeed = 0.005;
let currentPaletteIndex = 0;
let cascadeOffset = 0;
let mouse = new THREE.Vector2();
let raycaster = new THREE.Raycaster();
raycaster.params.Points.threshold = 0.5;

// Paletas de colores
const colorPalettes = [
    [0xff0000, 0x00ff00, 0x0000ff, 0xffff00, 0xff00ff, 0x00ffff],
    [0xffd700, 0xffa500, 0xffff00, 0xffffff, 0xffb347],
    [0x0080ff, 0x00ffff, 0x4169e1, 0x87ceeb, 0xffffff],
    [0xff00ff, 0x9370db, 0xffff00, 0xff1493, 0xda70d6]
];

// Inicializar
function initTree() {
    const canvas = document.getElementById('arbolCanvas');
    if (!canvas) return;

    scene = new THREE.Scene();
    scene.background = new THREE.Color(0x000000);

    camera = new THREE.PerspectiveCamera(60, canvas.clientWidth / canvas.clientHeight, 0.1, 1000);
    camera.position.z = 20;
    camera.position.y = 0;

    renderer = new THREE.WebGLRenderer({ canvas, antialias: true });
    renderer.setSize(canvas.clientWidth, canvas.clientHeight);
    renderer.setPixelRatio(window.devicePixelRatio);

    canvas.style.cursor = 'crosshair';

    createBackgroundStars();
    createTreeParticles();
    createFallingParticles();
    createTopStar();
    setupControls();

    canvas.addEventListener('mousemove', onMouseMove);
    window.addEventListener('resize', onWindowResize);

    animate();
}

// Estrellas de fondo
function createBackgroundStars() {
    const geometry = new THREE.BufferGeometry();
    const vertices = [];
    for (let i = 0; i < 500; i++) {
        vertices.push((Math.random() - 0.5) * 100, (Math.random() - 0.5) * 100, (Math.random() - 0.5) * 100);
    }
    geometry.setAttribute('position', new THREE.Float32BufferAttribute(vertices, 3));
    const material = new THREE.PointsMaterial({ color: 0xffffff, size: 0.1, transparent: true, opacity: 0.3 });
    scene.add(new THREE.Points(geometry, material));
}

// Árbol de partículas - FORMA MÁS ANCHA
function createTreeParticles() {
    const geometry = new THREE.BufferGeometry();
    const positions = [], colors = [], sizes = [];
    const palette = colorPalettes[currentPaletteIndex];
    const layers = 70, particlesPerLayer = 40, height = 14, baseRadius = 5;

    for (let i = 0; i < layers; i++) {
        const y = (i / layers) * height - height / 2;
        // Forma lineal, menos puntiaguda
        const radius = baseRadius * (1 - i / layers);
        const angleOffset = (i / layers) * Math.PI * 6;

        for (let j = 0; j < particlesPerLayer; j++) {
            const angle = (j / particlesPerLayer) * Math.PI * 2 + angleOffset;
            const r = radius * (0.7 + Math.random() * 0.3);
            positions.push(Math.cos(angle) * r, y, Math.sin(angle) * r);
            const color = new THREE.Color(palette[Math.floor(Math.random() * palette.length)]);
            colors.push(color.r, color.g, color.b);
            sizes.push(0.15 + Math.random() * 0.1);
        }
    }

    geometry.setAttribute('position', new THREE.Float32BufferAttribute(positions, 3));
    geometry.setAttribute('color', new THREE.Float32BufferAttribute(colors, 3));
    geometry.setAttribute('size', new THREE.Float32BufferAttribute(sizes, 1));

    const canvas = document.createElement('canvas');
    canvas.width = 32;
    canvas.height = 32;
    const ctx = canvas.getContext('2d');
    const gradient = ctx.createRadialGradient(16, 16, 0, 16, 16, 16);
    gradient.addColorStop(0, 'rgba(255, 255, 255, 1)');
    gradient.addColorStop(0.4, 'rgba(255, 255, 255, 0.8)');
    gradient.addColorStop(1, 'rgba(255, 255, 255, 0)');
    ctx.fillStyle = gradient;
    ctx.fillRect(0, 0, 32, 32);

    const material = new THREE.PointsMaterial({
        size: 0.25,
        vertexColors: true,
        transparent: true,
        opacity: 0.95,
        blending: THREE.AdditiveBlending,
        map: new THREE.CanvasTexture(canvas),
        sizeAttenuation: true
    });

    treeParticles = new THREE.Points(geometry, material);
    scene.add(treeParticles);
}

// Partículas cayendo
function createFallingParticles() {
    const geometry = new THREE.BufferGeometry();
    const positions = [], colors = [], velocities = [], sizes = [];
    const palette = colorPalettes[currentPaletteIndex];

    for (let i = 0; i < 200; i++) {
        positions.push((Math.random() - 0.5) * 2, 7.5 + Math.random() * 2, (Math.random() - 0.5) * 2);
        const color = new THREE.Color(palette[Math.floor(Math.random() * palette.length)]);
        colors.push(color.r, color.g, color.b);
        velocities.push((Math.random() - 0.5) * 0.02, -0.02 - Math.random() * 0.03, (Math.random() - 0.5) * 0.02);
        sizes.push(0.1 + Math.random() * 0.15);
    }

    geometry.setAttribute('position', new THREE.Float32BufferAttribute(positions, 3));
    geometry.setAttribute('color', new THREE.Float32BufferAttribute(colors, 3));
    geometry.setAttribute('velocity', new THREE.Float32BufferAttribute(velocities, 3));
    geometry.setAttribute('size', new THREE.Float32BufferAttribute(sizes, 1));

    const canvas = document.createElement('canvas');
    canvas.width = 32;
    canvas.height = 32;
    const ctx = canvas.getContext('2d');
    const gradient = ctx.createRadialGradient(16, 16, 0, 16, 16, 16);
    gradient.addColorStop(0, 'rgba(255, 255, 255, 1)');
    gradient.addColorStop(0.4, 'rgba(255, 255, 255, 0.8)');
    gradient.addColorStop(1, 'rgba(255, 255, 255, 0)');
    ctx.fillStyle = gradient;
    ctx.fillRect(0, 0, 32, 32);

    const material = new THREE.PointsMaterial({
        size: 0.2,
        vertexColors: true,
        transparent: true,
        opacity: 0.8,
        blending: THREE.AdditiveBlending,
        map: new THREE.CanvasTexture(canvas),
        sizeAttenuation: true
    });

    fallingParticles = new THREE.Points(geometry, material);
    scene.add(fallingParticles);
}

// Estrella sprite que gira de frente
function createTopStar() {
    const canvas = document.createElement('canvas');
    canvas.width = 128;
    canvas.height = 128;
    const ctx = canvas.getContext('2d');

    ctx.fillStyle = '#FFD700';
    ctx.shadowColor = '#FFFF00';
    ctx.shadowBlur = 20;

    const centerX = 64, centerY = 64, outerRadius = 50, innerRadius = 20, points = 5;
    ctx.beginPath();
    for (let i = 0; i < points * 2; i++) {
        const radius = i % 2 === 0 ? outerRadius : innerRadius;
        const angle = (i / (points * 2)) * Math.PI * 2 - Math.PI / 2;
        const x = centerX + Math.cos(angle) * radius;
        const y = centerY + Math.sin(angle) * radius;
        if (i === 0) ctx.moveTo(x, y);
        else ctx.lineTo(x, y);
    }
    ctx.closePath();
    ctx.fill();

    const material = new THREE.SpriteMaterial({
        map: new THREE.CanvasTexture(canvas),
        transparent: true,
        opacity: 1
    });

    star = new THREE.Sprite(material);
    star.position.set(0, 7.5, 0);
    star.scale.set(1.2, 1.2, 1);

    const starLight = new THREE.PointLight(0xffd700, 2, 10);
    starLight.position.set(0, 7.5, 0);
    scene.add(starLight);
    scene.add(star);
}

// Controles
function setupControls() {
    const btnColores = document.getElementById('btnCambiarColores');
    const btnVelocidad = document.getElementById('btnVelocidad');
    if (btnColores) btnColores.addEventListener('click', changeColors);
    if (btnVelocidad) btnVelocidad.addEventListener('click', changeSpeed);
}

function changeColors() {
    currentPaletteIndex = (currentPaletteIndex + 1) % colorPalettes.length;
    updateTreeColors();
    updateFallingColors();
}

function updateTreeColors() {
    const palette = colorPalettes[currentPaletteIndex];
    const colors = treeParticles.geometry.attributes.color.array;
    for (let i = 0; i < colors.length; i += 3) {
        const color = new THREE.Color(palette[Math.floor(Math.random() * palette.length)]);
        colors[i] = color.r;
        colors[i + 1] = color.g;
        colors[i + 2] = color.b;
    }
    treeParticles.geometry.userData.originalColors = colors.slice();
    treeParticles.geometry.attributes.color.needsUpdate = true;
}

function updateFallingColors() {
    const palette = colorPalettes[currentPaletteIndex];
    const colors = fallingParticles.geometry.attributes.color.array;
    for (let i = 0; i < colors.length; i += 3) {
        const color = new THREE.Color(palette[Math.floor(Math.random() * palette.length)]);
        colors[i] = color.r;
        colors[i + 1] = color.g;
        colors[i + 2] = color.b;
    }
    fallingParticles.geometry.attributes.color.needsUpdate = true;
}

function changeSpeed() {
    const speeds = [0.002, 0.005, 0.01, 0.015];
    const currentIndex = speeds.indexOf(rotationSpeed);
    const nextIndex = (currentIndex + 1) % speeds.length;
    rotationSpeed = speeds[nextIndex];
    const btn = document.getElementById('btnVelocidad');
    const speedNames = ['Lenta', 'Normal', 'Rápida', 'Muy Rápida'];
    btn.textContent = `Velocidad: ${speedNames[nextIndex]}`;
    setTimeout(() => btn.textContent = 'Velocidad', 1500);
}

function onMouseMove(event) {
    const canvas = document.getElementById('arbolCanvas');
    const rect = canvas.getBoundingClientRect();
    mouse.x = ((event.clientX - rect.left) / rect.width) * 2 - 1;
    mouse.y = -((event.clientY - rect.top) / rect.height) * 2 + 1;
}

function onWindowResize() {
    const canvas = document.getElementById('arbolCanvas');
    if (!canvas) return;
    camera.aspect = canvas.clientWidth / canvas.clientHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(canvas.clientWidth, canvas.clientHeight);
}

function animate() {
    requestAnimationFrame(animate);

    if (treeParticles) {
        treeParticles.rotation.y += rotationSpeed;
        const positions = treeParticles.geometry.attributes.position.array;
        const colors = treeParticles.geometry.attributes.color.array;
        const originalColors = treeParticles.geometry.userData.originalColors || colors.slice();

        if (!treeParticles.geometry.userData.originalColors) {
            treeParticles.geometry.userData.originalColors = colors.slice();
        }

        raycaster.setFromCamera(mouse, camera);
        const intersects = raycaster.intersectObject(treeParticles);

        for (let i = 0; i < colors.length; i += 3) {
            colors[i] = originalColors[i];
            colors[i + 1] = originalColors[i + 1];
            colors[i + 2] = originalColors[i + 2];
        }

        if (intersects.length > 0) {
            const intersectedIndex = intersects[0].index;
            const range = 50;
            for (let i = Math.max(0, intersectedIndex - range); i < Math.min(positions.length / 3, intersectedIndex + range); i++) {
                const distance = Math.abs(i - intersectedIndex);
                const brightness = 1 + (1 - distance / range) * 2.5;
                colors[i * 3] = Math.min(1, originalColors[i * 3] * brightness);
                colors[i * 3 + 1] = Math.min(1, originalColors[i * 3 + 1] * brightness);
                colors[i * 3 + 2] = Math.min(1, originalColors[i * 3 + 2] * brightness);
            }
        }

        treeParticles.geometry.attributes.color.needsUpdate = true;
    }

    if (fallingParticles) {
        const positions = fallingParticles.geometry.attributes.position.array;
        const velocities = fallingParticles.geometry.attributes.velocity.array;
        for (let i = 0; i < positions.length; i += 3) {
            positions[i] += velocities[i];
            positions[i + 1] += velocities[i + 1];
            positions[i + 2] += velocities[i + 2];
            if (positions[i + 1] < -7) {
                positions[i] = (Math.random() - 0.5) * 2;
                positions[i + 1] = 7.5 + Math.random() * 2;
                positions[i + 2] = (Math.random() - 0.5) * 2;
            }
        }
        fallingParticles.geometry.attributes.position.needsUpdate = true;
    }

    if (star) {
        // Rotar de frente (en el material del sprite)
        star.material.rotation += rotationSpeed * 2;
        // Pulso
        const pulse = Math.sin(Date.now() * 0.003) * 0.15 + 1;
        star.scale.set(1.2 * pulse, 1.2 * pulse, 1);
    }

    renderer.render(scene, camera);
}

if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initTree);
} else {
    initTree();
}
